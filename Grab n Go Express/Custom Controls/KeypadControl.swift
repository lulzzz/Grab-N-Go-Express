//
//  KeypadControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol KeypadControlDelegate{
    @objc optional func keypadDigitPressed(_ digitPressed: String)
    @objc optional func keypadClear()
}

class KeypadControl : UIView
{

    
    var buttonWidth: CGFloat = 70;
    let buttonSpacing: CGFloat = 22;

    var keypadControlWidth: CGFloat = 22*4+50*3
    var keypadControlHeight: CGFloat = 22*5+50*4
    
    enum keyboardType{
        case keypad
        case keyboard
    }
    
    var inputType: keyboardType = .keypad
    
    var delegate:KeypadControlDelegate?
    
    override init (frame : CGRect) {
        super.init(frame : frame)

        if(UIDevice.current.userInterfaceIdiom == .pad)
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
    
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
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
        
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            //self.frame = CGRect(x: 0, y: 0, width: 22*4+90*3, height: 22*5+90*4))
        }
        else
        {
            //self.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        }
        
        if(inputType == .keypad)
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
        createKeypadDigit("1", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing, yPos: buttonSpacing)
        createKeypadDigit("2", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing)
        createKeypadDigit("3", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing)
        
        createKeypadDigit("4", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("5", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("6", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing)
        
        createKeypadDigit("7", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("8", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        createKeypadDigit("9", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
        createKeypadDigit("0", digitPressed: #selector(KeypadControl.digitPressed(_:)), xPos: buttonSpacing, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
        createClearDigit("Clear", digitPressed: #selector(KeypadControl.clearPressed(_:)), xPos: buttonSpacing+buttonWidth+22, yPos: buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing+buttonWidth+buttonSpacing)
        
    }
    
    func createKeypadDigit(_ digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        //let button = UIButton(type: UIButtonType.Custom) as UIButton
        //UIButton(type: UIButtonType.System) as UIButton
        let button = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonWidth)
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
        button.setBackgroundImage("keypad_button_background3.png")
        button.titleLabel!.font = UIFont(name: "Arial", size: 58.0)
        }
        else
        {
        button.setBackgroundImage("keypad_button_background@1x.png")
        button.titleLabel!.font = UIFont(name: "Arial", size: 28.0)
            //button.backgroundColor = UIColor.blueColor()
        }
        
        button.setTitle(digit, for: UIControlState())
        button.setTitleColor(UIColor.blue, for: UIControlState())
        
        
        button.addTarget(self, action: digitPressed, for: UIControlEvents.touchDown)
        addSubview(button)
    }
    
    func createClearDigit(_ digit: String, digitPressed: Selector, xPos: CGFloat, yPos: CGFloat)
    {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
        button.frame = CGRect(x: xPos, y: yPos, width: buttonWidth*2+buttonSpacing, height: buttonWidth)
            button.setBackgroundImage("enterkey_button_background.png")
        }
        else
        {
        button.frame = CGRect(x: xPos, y: yPos, width: buttonWidth*2+buttonSpacing, height: buttonWidth)
            button.backgroundColor = UIColor.blue
        }
        
        button.setTitle(digit, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel!.font = UIFont(name: "Arial", size: 40.0)
        button.addTarget(self, action: #selector(KeypadControl.clearPressed(_:)), for: UIControlEvents.touchUpInside)
        addSubview(button)
    }
    
    func digitPressed(_ sender: UIButton)
    {
        delegate?.keypadDigitPressed!(sender.titleLabel!.text!)
    }
    
    func clearPressed(_ sender: UIButton)
    {
        delegate?.keypadClear!()
    }
    
    func createKeyboardKeys()
    {
        
    }
}


