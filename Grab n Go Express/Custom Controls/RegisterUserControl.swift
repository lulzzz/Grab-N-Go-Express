//
//  RegisterUserControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol RegisterUserControlDelegate{
    optional func errorOK()
    optional func errorCancel()
    func registrationCompleted()
}


class RegisterUserControl: UIView, KeypadControlDelegate, DTDeviceDelegate {
    
    var delegate: RegisterUserControlDelegate?
    
    var dtdevices: DTDevices = DTDevices()
    
    let okButton   = UIButton(type: UIButtonType.System) as UIButton
    let cancelButton   = UIButton(type: UIButtonType.System) as UIButton
    let label = UILabel()
    let inputTextField = UITextField()
    
    let swipedData: String = ""
    
    var track1: String = ""
    var track2: String = ""
    var track3: String = ""
    
    enum registrationState{
        case justStarted
        case creditCardSwiped
        case zipCodeEntered
        case ccvEntered
        case manualEnterCreditCard
        case manualEnterExpirationDate
    }
    
    var currentState: registrationState = .justStarted
    var justStartedText: String = "Registration is quick and easy\nIt takes less than a minute"
    let zipcodeText = "What is your billing zip code?"
    let creditCardSwipedText = "Swipe Your Credit Card"
    let ccvText = "Please enter the CCV code"
    
    var registration: Registration!
    
    var screenSize: CGRect = CGRect()
    
    
    
    override init (frame : CGRect) {
        
        super.init(frame : frame)
        
        registration = Registration()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        keypadControl.delegate = self
        label.numberOfLines = 0
        
        self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
        
        let btnWidth: CGFloat = 210
        let btnHeight: CGFloat = 52
        let btnSpacing: CGFloat = 5
        
        // If we're in an iPad
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
            label.font =  UIFont(name: "CardenioModern-Bold", size: 61.0)
            
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            
        okButton.frame = CGRectMake(self.frame.width/2-btnWidth/2-btnWidth/2-btnSpacing, self.frame.height-btnHeight-btnSpacing-25, btnWidth, btnHeight)
            
        cancelButton.frame = CGRectMake(self.frame.width/2-btnWidth/2+btnWidth/2+btnSpacing, self.frame.height-btnHeight-btnSpacing-25, btnWidth, 50)
        }
        else
        {
            // If we're in an iPhone
            self.frame = CGRect(x: 0, y: screenSize.height/2-screenSize.height/4, width: screenSize.width, height: screenSize.height/2)
            label.font =  UIFont(name: "CardenioModern-Bold", size: 30.0)
            
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2)
            
            okButton.frame = CGRectMake(self.frame.width/2-btnWidth/2, self.frame.height-btnHeight-btnSpacing-btnHeight-5, btnWidth, btnHeight)
            
            cancelButton.frame = CGRectMake(self.frame.width/2-btnWidth/2, self.frame.height-btnHeight-btnSpacing, btnWidth, btnHeight)
            inputTextField.hidden = true
        }
        
        backgroundColor = UIColor.whiteColor()
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 0.5
        clipsToBounds = true

        okButton.backgroundColor = UIColor.whiteColor()
        okButton.layer.borderColor = UIColor.blackColor().CGColor
        okButton.layer.borderWidth = 1.00
        okButton.setTitle("OK", forState: UIControlState.Normal)
        okButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        okButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 50.0)
        okButton.addTarget(self, action: "ok", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(okButton)
        
        cancelButton.backgroundColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
        cancelButton.setTitle("CANCEL", forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36.0)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(cancelButton)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.text = "Registration is quick and easy\nIt takes less than a minute"
       
        label.textColor = UIColor.blackColor()
        addSubview(label)
        superview?.alpha = 0.00

        dtdevices.addDelegate(self)
        dtdevices.connect()
        
    }
    
    convenience init(errorText: String)
    {
        self.init(frame: CGRect.zero)
        label.text = errorText
    }
    
    func ok()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.label.alpha = 0.0
                //self.okButton.alpha = 0.0
                
            }, completion: {_ in
                self.label.alpha = 1.0
                self.label.text = self.getNextStateText()
                //self.okButton.setTitle("Next", forState: .Normal)
        });
        
    }
    
    var keypadControl: KeypadControl = KeypadControl()
    var bResizeFrame: Bool = false;
    
    func testCardSwipe()
    {
            magneticCardData("%B4815880012431054^CHRISTNER/JOEL ^1904101100001100000000447000000?", track2: "", track3: "")
    }
    
    func centerCancelButtonAnimated()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.label.alpha = 1.0
                self.cancelButton.alpha = 1.0
                self.cancelButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                
            }, completion: nil)
    }
    
    func getNextStateText() -> String
    {
        var rVal: String = ""
        
        if(currentState == .justStarted)
        {
            if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
            {
                
            }
            else
            {
                currentState = .manualEnterCreditCard
            }
        }
        
        switch(currentState)
        {
        case .justStarted:
            currentState = .creditCardSwiped
            rVal = creditCardSwipedText
            UIView.animateWithDuration(0.5, delay: 0.0,
                options: .CurveEaseOut, animations: {
                    self.label.alpha = 1.0
                    self.cancelButton.alpha = 1.0
                    self.okButton.alpha = 0.0
                    self.cancelButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                }, completion: nil)
            label.text = rVal

            //var timer = NSTimer()
            //timer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: Selector("testCardSwipe"), userInfo: nil, repeats: false)
            
            break
        
        case .creditCardSwiped:
            rVal = zipcodeText
            label.text = rVal
            currentState = .zipCodeEntered

            setFrameC()
            self.okButton.alpha = 0.0
            addSubview(keypadControl)
            UIView.animateWithDuration(0.5, delay: 0.0,
                options: .CurveEaseOut, animations: {
                    self.setFrameA()
                    
                    self.setFrameD()
                    
                    self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                    self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                    self.inputTextField.backgroundColor = UIColor.whiteColor()
                    self.inputTextField.textAlignment = .Center
                    self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                    self.inputTextField.textColor = UIColor.blackColor()
                    
                    self.addSubview(self.inputTextField)
                }, completion:
                {_ in
            });
            //
            break;
            
        case .zipCodeEntered:
              self.setFrameE()
              rVal = ccvText
              self.label.text = rVal
              // 3039031874 2222
              break;
            
        case .ccvEntered:
            rVal = ccvText
            label.text = rVal
            currentState = .ccvEntered
            break
            
        case .manualEnterCreditCard:
            rVal = "Please enter your credit card number"
            self.label.text = rVal
            self.setFrameF()
            break
            
        case .manualEnterExpirationDate:
            self.setFrameF()
            rVal = "Please enter your expiration date\r\nMonth-Year, ex: 0819 = August 2019"
            self.label.text = rVal
            
            currentState = .manualEnterExpirationDate
            break
            
        }
        return rVal
    }
    
    func cancel()
    {
        
        delegate?.errorCancel!()
        hidden = true
        removeFromSuperview()
    }
    
    func setFrameA()
    {
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y-self.frame.height/3-100, width: self.frame.width, height: self.frame.height*2+100)
        }
        else
        {
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        }
    }
    
    func setFrameB()
    {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y+self.frame.height/2, width: self.frame.width, height: 0)
    }
    
    func setFrameC()
    {
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
        keypadControl.frame = CGRect(x: self.frame.width/2-keypadControl.keypadControlWidth/2, y: 191, width: keypadControl.keypadControlWidth, height: keypadControl.keypadControlHeight)
        }
        else
        {
            
        keypadControl.frame = CGRect(x: self.frame.width/2-keypadControl.keypadControlWidth/2, y: label.frame.height+label.frame.origin.y, width: keypadControl.keypadControlWidth, height: keypadControl.keypadControlHeight)

        }
    }
    
    func setFrameD()
    {
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
        self.label.frame = CGRect(x: self.label.frame.origin.x, y: 0, width: self.frame.width, height: 120)
        }
    }
    
    func setFrameE()
    {
        self.label.alpha = 1.0
        bClearTextLabel = true
        currentState = .ccvEntered
        setFrameC()
        self.okButton.alpha = 0.0
        addSubview(keypadControl)
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                // This is a hack
                if(self.bResizeFrame == true)
                {
                    self.setFrameA()
                }
                
                //self.label.frame = CGRect(x: self.label.frame.origin.x, y: 0, width: self.frame.width, height: 120)
                self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                self.inputTextField.backgroundColor = UIColor.whiteColor()
                self.inputTextField.textAlignment = .Center
                self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                self.inputTextField.textColor = UIColor.blackColor()
                self.addSubview(self.inputTextField)
                self.label.alpha = 1.0
                self.cancelButton.alpha = 1.0
                self.cancelButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                
            }, completion:
            {_ in
                
                
        });
    }
    
    func setFrameF()
    {
        setFrameC()
        self.okButton.alpha = 0.0
        addSubview(keypadControl)
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.setFrameA()
                
                self.setFrameD()
                
                self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                self.inputTextField.backgroundColor = UIColor.whiteColor()
                self.inputTextField.textAlignment = .Center
                self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                self.inputTextField.textColor = UIColor.blackColor()
                
                self.addSubview(self.inputTextField)
            }, completion:
            {_ in
        });
    }
    var bClearTextLabel = true
    
    func keypadDigitPressed(digitPressed: String) {
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
          inputTextField.text = inputTextField.text! + digitPressed
        }
        else
        {
            if(bClearTextLabel == true)
            {
                bClearTextLabel = false;
                label.text = ""
            }
            
            label.text = label.text! + digitPressed
            inputTextField.text = label.text
        }
        
        if(currentState == registrationState.zipCodeEntered)
        {
            if(inputTextField.text?.characters.count == 5)
            {
                registration.zipcode = inputTextField.text!
                inputTextField.text = "";

                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.label.alpha = 0.0
                        //self.okButton.alpha = 0.0
                        
                        
                    }, completion: {_ in
                        self.label.text = self.getNextStateText()
                        
                });
        }
        }
        
        if(currentState == registrationState.ccvEntered)
        {
            if(inputTextField.text?.characters.count==3)
            {
                registration.ccv = inputTextField.text!
                
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.setFrameB()
                        
                    }, completion: {_ in
                        
                        if(UIDevice.currentDevice().userInterfaceIdiom != .Pad)
                        {
                            self.registration.first_name = "Anonymous"
                            self.registration.last_name = "Anonymous"
                        }
                        self.delegate?.registrationCompleted()
                        self.cancel()
                    });             
            }
        }

        if(currentState == registrationState.manualEnterCreditCard)
        {
            if(inputTextField.text?.characters.count==4)
            {
                inputTextField.text = inputTextField.text! + "-"
                label.text = inputTextField.text
            }
            
            if(inputTextField.text?.characters.count==9)
            {
                inputTextField.text = inputTextField.text! + "-"
                label.text = inputTextField.text
            }
            
            if(inputTextField.text?.characters.count==14)
            {
                inputTextField.text = inputTextField.text! + "-"
                label.text = inputTextField.text
            }
            
            if(inputTextField.text?.characters.count==19)
            {
                inputTextField.text = inputTextField.text! + "-"
                label.text = inputTextField.text
                registration.cc_info = label.text!.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                currentState = .manualEnterExpirationDate
                label.text = getNextStateText()
                bClearTextLabel = true
                return
            }

        }
        
        if(currentState == registrationState.manualEnterExpirationDate)
        {
            
            if(inputTextField.text?.characters.count==2)
            {
                registration.expMonth = inputTextField.text!
                inputTextField.text = inputTextField.text! + "/"
                label.text = inputTextField.text
                
            }
            
            if(inputTextField.text?.characters.count==5)
            {
                inputTextField.text = inputTextField.text! + "-"
                currentState = .creditCardSwiped
                
                //registration.expYear = inputTextField.text!.substringFromIndex(inputTextField.text!.startIndex, 3)
                let newStartIndex = inputTextField.text!.startIndex.advancedBy(3)
                let newEndIndex = inputTextField.text!.startIndex.advancedBy(5)
                
                registration.expYear = inputTextField.text!.substringWithRange(newStartIndex..<newEndIndex)
                registration.exp_date = registration.expYear+registration.expMonth
                label.text = getNextStateText()
                if(UIDevice.currentDevice().userInterfaceIdiom != .Pad)
                {
                    bClearTextLabel = true
                }
            }
        }
        
    }
    

    func parseSwipedData()
    {
        
    }
    
    func barcodeData(barcode: String!, type: Int32) {
        label.text = barcode
    }
    
    func magneticCardData(track1: String!, track2: String!, track3: String!) {
        
        
        if let temp = track1
        {

            let fullName = temp.componentsSeparatedByString("^")
        
            var indexOfStartSentinal = temp.characters.indexOf("%")
            indexOfStartSentinal = indexOfStartSentinal?.advancedBy(2)

            let indexOfFirstCaret = temp.characters.indexOf("^")
            var indexOfSecondCaret = 0
            var bCont: Bool = false
            for character in temp.characters {
                if(character == "^")
                {
                    if(bCont==false)
                    {
                        bCont = true
                    }
                    else
                    {
                    break
                    }
                }
                ++indexOfSecondCaret
            }

            let expirationDateIndex = indexOfStartSentinal?.advancedBy(indexOfSecondCaret-1)
            let expirationDateEndIndex = expirationDateIndex?.advancedBy(4)
        
            var indexOfSlash = fullName[1].characters.indexOf("/")
            let indexOfEnd = fullName[1].characters.endIndex
            let lastName = fullName[1].substringToIndex(indexOfSlash!)
            indexOfSlash = indexOfSlash?.advancedBy(1)
            let lastNameRange = Range<String.Index>(start: indexOfSlash!, end: indexOfEnd)
            let firstName = fullName[1].substringWithRange(lastNameRange)
        
            let myRange = Range<String.Index>(start: indexOfStartSentinal!, end: indexOfFirstCaret!)
        
            let expirationDateRange = Range<String.Index>(start: expirationDateIndex!, end: expirationDateEndIndex!)
        
            let cardNumber = temp.substringWithRange(myRange)
            var expirationDate = temp.substringWithRange(expirationDateRange)
            // USA Technologies require, for reasons unknown, to be YY/MM, not MM/YY as provided in swipe data
            
            let expMonth: String = expirationDate.substringFromIndex(expirationDate.startIndex.advancedBy(2))
            
            let expDateRange = Range<String.Index>(
                start: expirationDate.startIndex.advancedBy(2),
                end: expirationDate.endIndex
                                            )
            expirationDate.removeRange(expDateRange)

            let expDateFinal = expirationDate + expMonth

            registration.first_name = firstName
            registration.last_name = lastName
            registration.cc_info = cardNumber
            registration.exp_date = expDateFinal
            label.text  = self.getNextStateText()
            
        }
        
    }
    
    func keypadClear()
    {
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            inputTextField.text = ""
            
        }
        else
        {
 
            label.text = ""
            inputTextField.text = ""
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
