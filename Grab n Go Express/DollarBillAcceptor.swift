//
//  DollarBillAcceptor.swift
//  DBV Acceptor
//
//  Created by Adam Arthur on 10/31/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import Foundation

/*
This class is designed to control an MEI AE Series 2000 Dollar Bill Acceptor
*/


@objc protocol DollarBillAcceptorDelegate{
    @objc func billAccepted(_ value: Double)
    @objc func log(_ msg: String)
    @objc func logs(_ msg: String)
    @objc func cableConnected()
    @objc func cableDisconnected()
    
}

class DollarBillAcceptor: NSObject, RscMgrDelegate
{
    enum currentState {
        case idling
        case accepting
        case escrow
        case stacked
    }
    
    enum currencyReceived {
        case one
        case two
        case five
        case ten
        case twenty
        case fifty
        case hundred
    }
    
    enum dbvStatus {
        case enabled_ACCEPTING_MONEY
        case disabled_NOTACCEPTING_MONEY
    }
    
    enum validatorCommands: UInt8 {
        case stx = 0x02
        case etx = 0x03
        case accept_MONEY = 0x04
        case donot_ACCEPT_MONEY = 0x05
        case default_LENGTH = 0x08
    }
    
    enum ValidatorResponses: UInt8 {
        case `default` = 1
        case stacking = 2
        case escrow = 4
        case stacked = 17
    }
    
    var validatorStatus: dbvStatus = .disabled_NOTACCEPTING_MONEY
    
    var rscMgr: RscMgr!
    
    var delegate: DollarBillAcceptorDelegate?
    
    var pollTimer: Timer = Timer();
   
    var bDBVInitialized: Bool = false;
    
    override init() {
        super.init()
        
    }
    
    func test()
    {
        rscMgr = RscMgr();
        
        rscMgr?.setDelegate(self);
        rscMgr?.enableExternalLogging(true)
        rscMgr?.enableTxRxExternalLogging(true);
    }
    
    func initDBV()
    {
        delegate?.log("Initializing Dollar Bill Validator");
        //pollTimer =
        rscMgr?.write("\u{02}\u{08}\u{10}\u{00}\u{10}\u{10}\u{03}\u{18}");
        sendDelayed("\u{02}\u{08}\u{10}\u{00}\u{10}\u{10}\u{03}\u{18}", delay: 200);
        sendDelayed("\u{02}\u{08}\u{11}\u{00}\u{10}\u{10}\u{03}\u{19}", delay: 400);
        sendDelayed("\u{02}\u{08}\u{60}\u{00}\u{00}\u{05}\u{03}\u{6d}", delay: 600);
        sendDelayed("\u{02}\u{08}\u{61}\u{00}\u{00}\u{00}\u{03}\u{69}", delay: 800);
        sendDelayed("\u{02}\u{08}\u{60}\u{00}\u{00}\u{01}\u{03}\u{69}", delay: 1000);
        sendDelayed("\u{02}\u{08}\u{10}\u{7f}\u{1c}\u{00}\u{03}\u{7b}", delay: 1200);
        Timer.scheduledTimer(timeInterval: 1400*0.001, target: self, selector: #selector(DollarBillAcceptor.startPolling), userInfo: nil, repeats: false)
        bDBVInitialized = true;
    }
    
    func startPolling()
    {
        pollTimer = Timer.scheduledTimer(timeInterval: (200*0.001), target: self, selector: #selector(DollarBillAcceptor.pollDBV), userInfo: nil, repeats: true)
    }
    
    func sendDelayed(_ cmd: String, delay: Double)
    {
        // Waits for delay, in milliseconds, and then 
        // sends the command to the dollar bill acceptor
        Timer.scheduledTimer(timeInterval: (delay*0.001), target: self, selector: #selector(DollarBillAcceptor.writeDataDelayed), userInfo: cmd, repeats: false)
    }
    
    func writeDataDelayed(_ timer: Timer)
    {
        let userInfo = timer.userInfo as! String
        rscMgr?.write(userInfo)
    }
    
    var bAck: Bool = true;
    var stackBill: Bool = false;
    
    // Constructs the omnibus packet
    // This packet is sent to the validator every 200 milliseconds
    // We expect a response for each command send
    
    func constructOmnibusPacket()
    {
        bAck = !bAck;
        
        var ackBit: String = "";
        
        if(bAck == false)
        {
            ackBit = "0";
            //rscMgr.writeString("\u{02}\u{08}\u{10}\u{7f}\u{1c}\u{00}\u{03}\u{7b}");
        }
        else
        {
            //rscMgr.writeString("\u{02}\u{08}\u{11}\u{7f}\u{1c}\u{00}\u{03}\u{7a}");
            ackBit = "1";
        }
        
        let ctrlByteStr: String = "0001000" + ackBit;
        let ctrlByte: UInt8 = UInt8(strtoul(ctrlByteStr, nil, 2));
        
        let dataByteZeroStr: String = "01111111";
        var dataByteZero: UInt8 = UInt8(strtoul(dataByteZeroStr, nil, 2));
        
        let dataByteOneStr: String = "00011100";
        var dataByteOne: UInt8 = UInt8(strtoul(dataByteOneStr, nil, 2));
        
        let dataByteTwoStr: String = "00000000";
        let dataByteTwo: UInt8 = UInt8(strtoul(dataByteTwoStr, nil, 2));

        if(stackBill == true)
        {
            dataByteOne = 0x3c;
        }
        
        if(validatorStatus == .disabled_NOTACCEPTING_MONEY)
        {
            dataByteZero = 0x00;
            dataByteOne = 0x1c;
            
        }
        
        let chk: UInt8 = (0x08 ^ ctrlByte ^ dataByteZero ^ dataByteOne ^ dataByteTwo);
        
        let bufferBytes: [UInt8] = [0x02, 0x08, ctrlByte, dataByteZero, dataByteOne, dataByteTwo, 0x03, chk];
        let buffer: Data = Data(bytes: UnsafePointer<UInt8>(bufferBytes as [UInt8]), count: bufferBytes.count);

        rscMgr?.write(buffer);

    }
    
    func enable()
    {
        delegate!.log("Enabled")
        validatorStatus = .enabled_ACCEPTING_MONEY
    }
    
    func disable()
    {
        delegate!.log("Disabled")
        validatorStatus = .disabled_NOTACCEPTING_MONEY
    }
    
    func enableDBV()
    {
        initDBV()
    }
    
    func shutdown()
    {
        pollTimer.invalidate()
        rscMgr?.write("\u{02}\u{08}\u{10}\u{00}\u{1c}\u{00}\u{03}\u{04}");
    }
    
    var lastCommand: UInt8 = 0;
    
    func parsePollResponse(_ pollResponse: String)
    {
        
        // We deconstruct the response we received from the bill validator
        // and do something useful with the information
        var buf = [UInt8](pollResponse.utf8)
        if(buf.count < 5)
        {
            bAck = !bAck;
            return
        }
        
        //delegate?.logs!(":\ta")
        if(lastCommand != buf[3])
        {
            
            //delegate?.log!((String(buf[3])) + ":" + String(buf.count))
            lastCommand = buf[3];
        }
        //delegate?.logs!("b")
        if(buf[0] != 0x02)
        {
            //delegate?.log!(("Buf[0] does not equal STX!"))
            //return;
        }
        //delegate?.logs!("c")
        if(buf[1] != 0x2b)
        {
            //
            //return;
        }
        //delegate?.logs!("d")
        if(buf[3] == 2)
        {
            //delegate?.log!(("Bill Stacking"))
        }
        //delegate?.logs!("e")
        if(buf[3] == 4)
        {
            //delegate?.log!(("Bill Escrowed"))
            stackBill = true
        }
        //delegate?.logs!("f")
        if(buf[3] == 2)
        {
            //delegate?.log!(("Bill Stacking"))
        }
        //delegate?.logs!("g")
        if(buf[3] == 17)
        {
            //delegate?.log!(("Bill Stacked"))
            stackBill = false;
            
            if(buf[5] == 8)
            {
                delegate!.log("Bill Stacked:  $1.00 USD");
                delegate?.billAccepted(1.00)
            }
            
            if(buf[5] == 24)
            {
                delegate?.log("Bill Stacked: $5.00 USD");
                delegate?.billAccepted(5.00)
            }
            
            if(buf[5] == 32)
            {
                delegate?.log("Bill Stacked: $10.00 USD");
                delegate?.billAccepted(10.00)
            }
            
            if(buf[5] == 40)
            {
                delegate!.log("Bill Stacked: $20.00 USD");
                delegate?.billAccepted(20.00)
            }
        }
        //delegate?.log!("---")
    }
    
    func pollDBV()
    {
        constructOmnibusPacket()
    }
    
    func startCommThread()
    {
        rscMgr?.setDelegate(self);
        rscMgr?.enableExternalLogging(true)
        rscMgr?.enableTxRxExternalLogging(true);
    }
    
    func cableConnected(_ protocol: String!) {
        
        delegate?.cableConnected()
        
        let dataSizeType: DataSizeType = DataSizeType(0x07)
        let parityType: ParityType = ParityType(0x02)
        let stopBitsType: StopBitsType = StopBitsType(0x01)
        rscMgr?.setBaud(9600)
        rscMgr?.setDataSize(dataSizeType)
        rscMgr?.setParity(parityType)
        rscMgr?.setStopBits(stopBitsType)
        initDBV();
        
    }
    
    func cableDisconnected() {
        delegate?.cableDisconnected()
        
        pollTimer.invalidate()
        rscMgr?.write("\u{02}\u{08}\u{10}\u{00}\u{1c}\u{00}\u{03}\u{04}");
        //sendDelayed("\u{02}\u{08}\u{10}\u{00}\u{1c}\u{00}\u{03}\u{04}", delay: 200);
        delegate?.cableDisconnected();
        
    }
    
    func readBytesAvailable(_ length: UInt32) {
        let str: String = rscMgr!.getStringFromBytesAvailable();
        parsePollResponse(str);
    }
    
    @objc func didWrite(_ data: Data!) {
    }
    
    func portStatusChanged() {
    }
}
