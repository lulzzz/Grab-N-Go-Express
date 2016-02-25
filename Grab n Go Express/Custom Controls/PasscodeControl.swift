//
//  PasscodeControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol PasscodeControlDelegate{
    optional func passcodeCompletion(passcode: String)
}

class PasscodeControl : SingleInputControl
{
    // The default is a keypad, but the plan is to enable text input as well
    
    var delegate:PasscodeControlDelegate?
    
    var passcode = ""
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init (instructionsText: String) {
        
        let keypadControlWidth: CGFloat = 22*4+90*3
        let keypadControlHeight: CGFloat = 22*5+90*4
        let keypadRect: CGRect = CGRect(x: -500, y: 380-250, width: keypadControlWidth, height: keypadControlHeight+250)
        self.init(frame: keypadRect)
        
        label.text = instructionsText
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func keypadDigitPressed(digitPressed: String) {
        // A keypad digit was pressed, update the text field!
        
        let  char = digitPressed.cStringUsingEncoding(NSUTF8StringEncoding)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            passcode = ""
            textInput.text = ""
            return
        }
        
        textInput.text = formatAsPasscode(textInput.text! + "*")
        passcode += digitPressed
        if(textInput.text!.characters.count == 8)
        {
            delegate?.passcodeCompletion!(passcode)
        }
    }
    
    override func keypadClear() {
        super.keypadClear()
        passcode = ""
    }
    
    func formatAsPasscode(formatString: String) -> String
    {
        return formatString + " ";
    }
}

