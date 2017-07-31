//
//  BarcodeControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 4/12/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol BarcodeControlDelegate{
    func listItems(_ barcode: String)
}

class BarcodeControl : SingleInputControl
{

    var delegate:BarcodeControlDelegate?
    
    var barcode = ""
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (instructionsText: String) {
        
        let keypadControlWidth: CGFloat = 22*4+90*3
        let keypadControlHeight: CGFloat = 22*5+90*4
        let keypadRect: CGRect = CGRect(x: -500, y: 380-250, width: keypadControlWidth, height: keypadControlHeight+250)
        self.init(frame: keypadRect)
        
        label.text = instructionsText

    }
    
    override func keypadDigitPressed(_ digitPressed: String) {
        textInput.text = textInput.text! + digitPressed
        delegate?.listItems(textInput.text!);
    }
    

}
