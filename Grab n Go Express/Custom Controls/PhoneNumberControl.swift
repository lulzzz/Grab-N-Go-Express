//
//  PhoneNumberControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol PhoneNumberControlDelegate{
    @objc optional func phoneNumberCompletion(_ phoneNumber: String)
}

class PhoneNumberControl : SingleInputControl
{
    // The default is a keypad, but the plan is to enable text input as well
    
    var delegate:PhoneNumberControlDelegate?
    
    var phoneNumber = ""
    
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
    
    override func keypadDigitPressed(_ digitPressed: String) {
        var digitPressed = digitPressed
        // A keypad digit was pressed, update the text field!
        //var str = string
        let  char = digitPressed.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            phoneNumber = ""
            textInput.text = ""
            digitPressed = ""
            return
        }

        textInput.text = formatAsPhone(textInput.text! + digitPressed)
        phoneNumber += digitPressed
        if(textInput.text!.characters.count == 14)
        {
            delegate?.phoneNumberCompletion!(phoneNumber)
        }
    }
    
    override func keypadClear() {
        super.keypadClear()
        phoneNumber = ""
    }
    
    func formatAsPhone(_ formatString: String) -> String
    {
        let stringLength = formatString.characters.count
        if(stringLength == 1)
        {
            return "(" + formatString
        }
        
        if(stringLength == 4)
        {
            return formatString + ") "
        }
        
        if(stringLength == 9)
        {
            return formatString + "-"
        }
        return formatString
    }
}
