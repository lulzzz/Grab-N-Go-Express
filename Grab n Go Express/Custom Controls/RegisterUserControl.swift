//
//  RegisterUserControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol RegisterUserControlDelegate{
    @objc optional func errorOK()
    @objc optional func errorCancel()
    func registrationCompleted()
}

class WizardControl: UIView {

    var screenSize: CGRect = CGRect()
    
    let okButton   = UIButton(type: UIButtonType.system) as UIButton
    let cancelButton   = UIButton(type: UIButtonType.system) as UIButton
    let cashOnlyButton = UIButton(type: UIButtonType.system) as UIButton
    let label = UILabel()
    let inputTextField = UITextField()
    
    var biPad = false;
    
    let btnWidth: CGFloat = 210
    let btnHeight: CGFloat = 52
    let btnSpacing: CGFloat = 5
    
    override init (frame : CGRect) {
        
        super.init(frame : frame)
        
        screenSize = UIScreen.main.bounds
        
        // If we're in an iPad
        if(biPad == true)
        {
            self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
            label.font =  UIFont(name: "CardenioModern-Bold", size: 61.0)
            
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            
            okButton.frame = CGRect(x: self.frame.width/2-btnWidth/2-btnWidth/2-btnSpacing, y: self.frame.height-btnHeight-btnSpacing-25, width: btnWidth, height: btnHeight)
            
            cancelButton.frame = CGRect(x: self.frame.width/2-btnWidth/2+btnWidth/2+btnSpacing, y: self.frame.height-btnHeight-btnSpacing-25, width: btnWidth, height: 50)
            
            cashOnlyButton.frame = CGRect(x: self.frame.width/2-btnWidth/2+btnWidth/2+btnSpacing, y: self.frame.height-btnHeight-btnSpacing-25-75, width: btnWidth, height: 50)
            
            
        }
        else
        {
            // If we're in an iPhone
            self.frame = CGRect(x: 0, y: screenSize.height/2-screenSize.height/4, width: screenSize.width, height: screenSize.height/2)
            label.font =  UIFont(name: "CardenioModern-Bold", size: 30.0)
            
            label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2)
            
            okButton.frame = CGRect(x: self.frame.width/2-btnWidth/2, y: self.frame.height-btnHeight-btnSpacing-btnHeight-5, width: btnWidth, height: btnHeight)
            
            cancelButton.frame = CGRect(x: self.frame.width/2-btnWidth/2, y: self.frame.height-btnHeight-btnSpacing, width: btnWidth, height: btnHeight)
            
            cashOnlyButton.frame = CGRect(x: self.frame.width/2-btnWidth/2, y: self.frame.height-btnHeight-btnSpacing, width: btnWidth, height: btnHeight)
            
            inputTextField.isHidden = true
        }
        
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
        okButton.backgroundColor = UIColor.white
        okButton.layer.borderColor = UIColor.black.cgColor
        okButton.layer.borderWidth = 1.00
        okButton.setTitle("OK", for: UIControlState())
        okButton.setTitleColor(UIColor.black, for: UIControlState())
        okButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 50.0)
        okButton.addTarget(self, action: #selector(RegisterUserControl.ok), for: UIControlEvents.touchUpInside)
        addSubview(okButton)
        
        cancelButton.backgroundColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
        cancelButton.setTitle("CANCEL", for: UIControlState())
        cancelButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36.0)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState())
        cancelButton.addTarget(self, action: #selector(RegisterUserControl.cancel), for: UIControlEvents.touchUpInside)
        addSubview(cancelButton)
        
        cashOnlyButton.backgroundColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
        cashOnlyButton.setTitle("CASH ONLY", for: UIControlState())
        cashOnlyButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36.0)
        cashOnlyButton.setTitleColor(UIColor.white, for: UIControlState())
        //cashOnlyButton.isHidden = true;
        cashOnlyButton.addTarget(self, action: #selector(RegisterUserControl.cashOnly), for: UIControlEvents.touchUpInside)
        //addSubview(cashOnlyButton)
        
        label.backgroundColor = UIColor.clear
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Change label to your initial instructions"
        
        label.textColor = UIColor.black
        addSubview(label)
        superview?.alpha = 0.00
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RegisterUserControl: WizardControl, KeypadControlDelegate, DTDeviceDelegate {
    
        var delegate: RegisterUserControlDelegate?
    
    var dtdevices: DTDevices = DTDevices()

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
    

    
    
    override init (frame : CGRect) {
        
        super.init(frame : frame)
        
        registration = Registration()
        keypadControl.delegate = self
        label.text = "Registration is quick and easy\nIt takes less than a minute"

    }
    
    convenience init(errorText: String)
    {
        self.init(frame: CGRect.zero)
        label.text = errorText
    }
    
    func ok()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
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
            if(biPad == true)
            {
                currentState = .manualEnterCreditCard
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
            UIView.animate(withDuration: 0.5, delay: 0.0,
                options: .curveEaseOut, animations: {
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
            bClearTextLabel = true
            label.text = rVal
            currentState = .zipCodeEntered

            setFrameC()
            self.okButton.alpha = 0.0
            addSubview(keypadControl)
            UIView.animate(withDuration: 0.5, delay: 0.0,
                options: .curveEaseOut, animations: {
                    self.setFrameA()
                    
                    self.setFrameD()
                    
                    self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                    self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                    self.inputTextField.backgroundColor = UIColor.white
                    self.inputTextField.textAlignment = .center
                    self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                    self.inputTextField.textColor = UIColor.black
                    
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
        isHidden = true
        removeFromSuperview()
    }
    
    func cashOnly()
    {
        registration.first_name = "Anonymous"
        registration.last_name = "Anonymous"
        delegate?.registrationCompleted()
        cancel()
    }
    
    func setFrameA()
    {
        
        if(biPad == true)
        {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y-self.frame.height/3-100, width: self.frame.width, height: self.frame.height*2+100)
        }
        else
        {
            let screenSize: CGRect = UIScreen.main.bounds
            self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        }
    }
    
    func setFrameB()
    {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y+self.frame.height/2, width: self.frame.width, height: 0)
    }
    
    func setFrameC()
    {
        if(biPad == true)
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
        if(biPad == true)
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
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
                // This is a hack
                if(self.bResizeFrame == true)
                {
                    self.setFrameA()
                }
                
                //self.label.frame = CGRect(x: self.label.frame.origin.x, y: 0, width: self.frame.width, height: 120)
                self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                self.inputTextField.backgroundColor = UIColor.white
                self.inputTextField.textAlignment = .center
                self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                self.inputTextField.textColor = UIColor.black
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
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
                self.setFrameA()
                
                self.setFrameD()
                
                self.cancelButton.frame.origin.y = self.frame.height-self.cancelButton.frame.height-22
                self.inputTextField.frame = CGRect(x: self.label.frame.origin.x, y: self.label.frame.height, width: self.frame.width, height: 75)
                self.inputTextField.backgroundColor = UIColor.white
                self.inputTextField.textAlignment = .center
                self.inputTextField.font = UIFont(name: "Archer-Bold", size: 68)
                self.inputTextField.textColor = UIColor.black
                
                self.addSubview(self.inputTextField)
            }, completion:
            {_ in
        });
    }
    
    func setFrameG()
    {
        setFrameA()
        
          keypadControl.frame = CGRect(x: 0, y: 0,
                                       width: keypadControl.keypadControlWidth, height: keypadControl.keypadControlHeight)
    }
    
    var bClearTextLabel = true
    
    func keypadDigitPressed(_ digitPressed: String) {
        
        if(biPad == true)
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

                UIView.animate(withDuration: 0.5, delay: 0.0,
                    options: .curveEaseOut, animations: {
                        self.label.alpha = 0.0
                        //self.okButton.alpha = 0.0
                        
                        
                    }, completion: {_ in
                        self.label.text = self.getNextStateText()
                        
                });
        }
        }
        
        if(currentState == registrationState.ccvEntered)
        {
            // For AMEX cards, allow 4
            var ccvCount = 3
            let index = registration.cc_info.characters.index(registration.cc_info.startIndex, offsetBy: 2)
            let amexStr = registration.cc_info.substring(to: index)
            if(amexStr == "34")
            {
             ccvCount = 4;
            }
            if(amexStr == "37")
            {
                ccvCount = 4
            }
            
            if(inputTextField.text?.characters.count==ccvCount)
            {
                registration.ccv = inputTextField.text!
                
                UIView.animate(withDuration: 0.5, delay: 0.0,
                    options: .curveEaseOut, animations: {
                        self.setFrameB()
                        
                    }, completion: {_ in
                        
                        //if(UIDevice.currentDevice().userInterfaceIdiom != .Pad)
                        //{
                            self.registration.first_name = "Anonymous"
                            self.registration.last_name = "Anonymous"
                        //}
                        self.delegate?.registrationCompleted()
                        self.cancel()
                    });             
            }
        }

        if(currentState == registrationState.manualEnterCreditCard)
        {
            // Display button - Cash Only Account
            //var cashOnlyAccount =

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
                registration.cc_info = label.text!.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
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
                let newStartIndex = inputTextField.text!.characters.index(inputTextField.text!.startIndex, offsetBy: 3)
                let newEndIndex = inputTextField.text!.characters.index(inputTextField.text!.startIndex, offsetBy: 5)
                
                registration.expYear = inputTextField.text!.substring(with: newStartIndex..<newEndIndex)
                registration.exp_date = registration.expYear+registration.expMonth
                label.text = getNextStateText()
                if(UIDevice.current.userInterfaceIdiom != .pad)
                {
                    bClearTextLabel = true
                }
            }
        }
        
    }
    

    func parseSwipedData()
    {
        
    }
    
    func barcodeData(_ barcode: String!, type: Int32) {
        label.text = barcode
    }
    
    func magneticCardData(_ track1: String!, track2: String!, track3: String!) {
        
        
        if let temp = track1
        {

            let fullName = temp.components(separatedBy: "^")
        
            var indexOfStartSentinal = temp.characters.index(of: "%")
            //indexOfStartSentinal = <#T##Collection corresponding to your index##Collection#>.index(indexOfStartSentinal?, offsetBy: 2)

            let indexOfFirstCaret = temp.characters.index(of: "^")
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
                indexOfSecondCaret += 1
            }

            //let expirationDateIndex = <#T##Collection corresponding to your index##Collection#>.index(indexOfStartSentinal?, offsetBy: indexOfSecondCaret-1)
            //let expirationDateEndIndex = <#T##String.CharacterView corresponding to your index##String.CharacterView#>.index(expirationDateIndex?, offsetBy: 4)
        
            var indexOfSlash = fullName[1].characters.index(of: "/")
            let indexOfEnd = fullName[1].characters.endIndex
            let lastName = fullName[1].substring(to: indexOfSlash!)
            //indexOfSlash = <#T##Collection corresponding to your index##Collection#>.index(indexOfSlash?, offsetBy: 1)
            let lastNameRange = (indexOfSlash! ..< indexOfEnd)
            let firstName = fullName[1].substring(with: lastNameRange)
        
            let myRange = (indexOfStartSentinal! ..< indexOfFirstCaret!)
        
            //let expirationDateRange = (expirationDateIndex! ..< expirationDateEndIndex!)
        
            let cardNumber = temp.substring(with: myRange)
            var expirationDate = "";//temp.substring(with: expirationDateRange)
            // USA Technologies require, for reasons unknown, to be YY/MM, not MM/YY as provided in swipe data
            
            let expMonth: String = expirationDate.substring(from: expirationDate.characters.index(expirationDate.startIndex, offsetBy: 2))
            
            let expDateRange = (expirationDate.characters.index(expirationDate.startIndex, offsetBy: 2) ..< expirationDate.endIndex)
            expirationDate.removeSubrange(expDateRange)

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

        if(biPad == true)
        {
            inputTextField.text = ""
            label.text = ""
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
