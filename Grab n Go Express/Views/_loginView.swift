//
//  LoginViewiPhone.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/24/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class loginView: LoginView, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerX = view.bounds.width / 2
        let bottomY = view.bounds.height
        let rightX = view.bounds.width

        transparentApple.hidden = true
        
        loginButton.removeFromSuperview()
        signupButton.removeFromSuperview()
        
        //logoView.removeFromSuperview()
        //arrowView.removeFromSuperview()
        //noAccountLabel.removeFromSuperview()
        
        //loginButton = UIButton()
        //loginButton.frame = CGRect( x: centerX-242/2, y: 226, width: 242, height: 65)
        //let img = UIImage(named: "background_button_@1x.png")
        //loginButton.setBackgroundImage(img, forState: UIControlState.Normal)
        //view.addSubview(loginButton)
        logoView.frame = CGRect(x: centerX-140/2, y: 50, width: 140, height: 143)
        logoOriginalFrame = logoView.frame
        
        loginButton = addButton("background_button_@1x.png", action: "login", text: "LOGIN", font: "Archer-Bold", fontSize: 40.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C)
        loginButtonOriginalX = loginButton.frame.origin.x
        
        signupButton = addButton("background_button_@1x.png", action: "signup", text: "SIGNUP FOR FREE", font: "Archer-Bold", fontSize: 24.0, xPos: 0.00, yPos: bottomY-90, xPosW: 0, yPosW: bottomY-90, textColor: 0x80392C)
        signupButtonOriginalX = signupButton.frame.origin.x
        
        arrowView.frame = CGRect(x: 80, y: signupButton.frame.origin.y+signupButton.frame.height-125, width: 71, height: 50)
        arrowView.transform = CGAffineTransformMakeScale(-1, 1)

        noAccountLabel.frame = CGRect(x: 145, y: signupButton.frame.origin.y+signupButton.frame.height-175, width: 160, height: 98)
        noAccountLabel.font = UIFont(name: "CardenioModern-Bold", size: 28)
        
        // Phone number / passcode controls
        
        phoneNumberControl.frame = CGRect(x: 0, y: 0, width: rightX, height: bottomY)
        
        phoneNumberControl.keypadControl.hidden = true
        phoneNumberControl.hatchedBackgroundView.frame = CGRect(x: 0, y: 125, width: rightX, height: 115)
        phoneNumberControl.textInput.frame = CGRect(x: 0, y: 125, width: rightX, height: 115)
        phoneNumberControl.label.frame = CGRect(x: 0, y: 25, width: rightX, height: 115)
        phoneNumberControl.textInput.delegate = self
        
        passcodeControl.frame = CGRect(x: 0, y: 0, width: rightX, height: bottomY)
        passcodeControl.keypadControl.hidden = true
        passcodeControl.hatchedBackgroundView.frame = CGRect(x: 0, y: 125, width: rightX, height: 115)
        passcodeControl.textInput.frame = CGRect(x: 0, y: 125, width: rightX, height: 115)
        passcodeControl.textInput.keyboardType = .NumberPad
        passcodeControl.label.frame = CGRect(x: 0, y: 25, width: rightX, height: 115)
        passcodeControl.textInput.delegate = self
    }
    
    override func login() {
        super.login();
        phoneNumberControl.textInput.becomeFirstResponder()
    }
    
    override func signup() {
        super.signup()
        phoneNumberControl.textInput.becomeFirstResponder()
    }
    
    override func passcodeCompletion(passcode: String) {
        super.passcodeCompletion(passcode)
        passcodeControl.textInput.endEditing(true)
        phoneNumberControl.textInput.endEditing(true)
    }
    
    override func advanceState()
    {
        super.advanceState()
        
        switch(loginStatus)
        {
        case .ObtainingPinNumberState:
            passcodeControl.textInput.becomeFirstResponder()
            break
            
        default:
           passcodeControl.textInput.endEditing(true)
           phoneNumberControl.textInput.endEditing(true)
            break
        }
    }
    
    override func resetScreen() {
        super.resetScreen()
        view.becomeFirstResponder()
        passcodeControl.textInput.endEditing(true)
        phoneNumberControl.textInput.endEditing(true)
    }
    
    override func animatedHideAnonymousState()
    {
        // Anonymous State UI
        //loginButton.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: .CurveEaseOut, animations: {
                self.loginButton.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5,
            options: .CurveEaseOut, animations: {
                self.signupButton.center.x += self.view.bounds.width
                //self.logoView.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
                self.logoView.alpha = 0.0
                self.transparentApple.alpha = 0
                self.noAccountLabel.alpha = 0
                self.arrowView.alpha = 0
                self.backgroundImageView.alpha = 0
            }, completion: {_ in
                self.setBackgroundImage("background_blue.png")
                self.backgroundImageView.alpha = 0
                self.phoneNumberControl.alpha = 1.0
                self.phoneNumberControl.hidden = false
                self.instructionLabel.hidden = false
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.backgroundImageView.alpha = 1.0
                        self.phoneNumberControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.phoneNumberControl.frame.origin.y, width: self.phoneNumberControl.frame.width, height: self.phoneNumberControl.frame.height)
                        
                        self.instructionLabel.alpha = 1.0
                    }, completion: nil);
                
                
            }
        )
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if(phoneNumberControl.textInput.isFirstResponder() == true)
        {
            phoneNumberControl.keypadDigitPressed(string)
        }
        
        if(passcodeControl.textInput.isFirstResponder())
        {
            passcodeControl.keypadDigitPressed(string)
            print(string)
        }
        
        return false
    }
}