//
//  KeypadControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol KeypadControlDelegate{
    optional func keypadDigitPressed(digitPressed: String)
    optional func keypadClear()
}

class KeypadControl : UIView
{

    
    var buttonWidth: CGFloat = 70;
    let buttonSpacing: CGFloat = 22;

    var keypadControlWidth: CGFloat = 22*4+50*3
    var keypadControlHeight: CGFloat = 22*5+50*4
    
    enum keyboardType{
        case Keypad
        case Keyboard
    }
    
    var inputType: keyboardType = .Keypad
    
    var delegate:KeypadControlDelegate?
    
    override init (frame : CGRect) {
        super.init(frame : frame)

        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            buttonWidth = 90
        }
        else
        {
            buttonWidth = 50
        }
        
        keypadControlWidth = 22*4+buttonWidth*3
        keypadControlHeight = 22*5+buttonWidth*4
        
        createControl()
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func createControl()
    {
        // Create my buttons
        self.backgroundColor = UIColorFromRGB(0xbbddec)
        
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            //self.frame = CGRect(x: 0, y: 0, width: 22*4+90*3, height: 22*5+90*4))
        }
        else
        {
            //self.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        }
        
        if(inputType == .Keypad)
        {
            createKeypadDigits()
        }
        else
        {
            createKeyboardKeys()
        }
    }
    
    func createKeypadDigits()
    {
        createKeypadDigit("1", digitPressed: "digitPressed:", xPos: buttonSpacing, yPos: buttonSpacing)
        createKeypadDigit("2", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing)
        createKeypadDigit("3", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing)
        
        createKeypadDigit("4", digitPressed: "digitPressed:", xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("5", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("6", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        
        createKeypadDigit("7", digitPressed: "digitPressed:", xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("8", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("9", digitPressed: "digitPressed:", xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
        createKeypadDigit("0", digitPressed: "digitPressed:", xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
        createClearDigit("Clear", digitPressed: "clearPressed:", xPos: buttonSpacing+buttonWidth+22, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
    }
    
    func createKeypadDigit(digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        //let button = UIButton(type: UIButtonType.Custom) as UIButton
        //UIButton(type: UIButtonType.System) as UIButton
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(xPos, yPos, buttonWidth, buttonWidth)
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
        button.setBackgroundImage("keypad_button_background3.png")
        button.titleLabel!.font = UIFont(name: "Arial", size: 58.0)
        }
        else
        {
        button.setBackgroundImage("keypad_button_background@1x.png")
        button.titleLabel!.font = UIFont(name: "Arial", size: 28.0)
            button.backgroundColor = UIColor.blueColor()
        }
        
        button.setTitle(digit, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
        
        button.addTarget(self, action: digitPressed, forControlEvents: UIControlEvents.TouchDown)
        addSubview(button)
    }
    
    func createClearDigit(digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        let button = UIButton(type: UIButtonType.Custom) as UIButton
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
        button.frame = CGRectMake(xPos, yPos, buttonWidth*2+buttonSpacing, buttonWidth)
            button.setBackgroundImage("enterkey_button_background.png")
        }
        else
        {
        button.frame = CGRectMake(xPos, yPos, buttonWidth*2+buttonSpacing, buttonWidth)
            button.backgroundColor = UIColor.blueColor()
        }
        
        button.setTitle(digit, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Arial", size: 40.0)
        button.addTarget(self, action: "clearPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(button)
    }
    
    func digitPressed(sender: UIButton)
    {
        delegate?.keypadDigitPressed!(sender.titleLabel!.text!)
    }
    
    func clearPressed(sender: UIButton)
    {
        delegate?.keypadClear!()
    }
    
    func createKeyboardKeys()
    {
        
    }
}


