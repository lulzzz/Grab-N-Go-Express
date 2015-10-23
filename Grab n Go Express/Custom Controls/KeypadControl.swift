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
    let keypadControlWidth: CGFloat = 22*4+90*3
    let keypadControlHeight: CGFloat = 22*5+90*4
    
    enum keyboardType{
        case Keypad
        case Keyboard
    }
    
    var inputType: keyboardType = .Keypad
    
    var delegate:KeypadControlDelegate?
    
    override init (frame : CGRect) {
        super.init(frame : frame)

        createControl()
    }
    
    convenience init () {
        self.init(frame:CGRect(x: 0, y: 0, width: 22*4+90*3, height: 22*5+90*4))
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
        let buttonWidth: CGFloat = 90;
        let buttonSpacing: CGFloat = 22;
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
        
        createClearDigit("Clear", digitPressed: "clearPressed:", xPos: buttonSpacing+90+22, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
    }
    
    func createKeypadDigit(digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        let button = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(xPos, yPos, 90, 90)
        button.setBackgroundImage("keypad_button_background.png")
        button.setTitle(digit, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Arial", size: 58.0)
        button.addTarget(self, action: digitPressed, forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(button)
    }
    
    func createClearDigit(digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        let button = UIButton(type: UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(xPos, yPos, 199, 90)
        button.setBackgroundImage("enterkey_button_background.png")
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


