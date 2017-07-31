//
//  SingleInputControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class SingleInputControl: UIView, KeypadControlDelegate{

    var instructions = ""
    let textInput: UITextField = UITextField()
    
    var label: UILabel = UILabel()
    var keypadControl: KeypadControl!
    var hatchedBackgroundView: UIImageView!
    
    override init (frame : CGRect) {
                
        super.init(frame : frame)
        
        let keypadControl: KeypadControl = KeypadControl(frame: CGRect(x: 0, y: 113+22+115, width: frame.width, height: frame.height-113-22-115))
        self.keypadControl = keypadControl
        keypadControl.delegate = self
        addSubview(keypadControl)
        
        backgroundColor = UIColor.clear
        
        let hatchedBackground: UIImage = UIImage(named: "hatched_background.png")!
        let hatchedBackgroundView = UIImageView(image: hatchedBackground)
        
        
        let textInputRect: CGRect = CGRect(x: frame.width/2-339/2, y: 200-115-22+22+22, width: 339, height: 115)
        addSubview(hatchedBackgroundView)
        hatchedBackgroundView.frame = textInputRect
        self.hatchedBackgroundView = hatchedBackgroundView
        
        let font = "Archer-Bold"
        let fontSize: CGFloat = 36.0
        let fontObj = UIFont(name: font, size: fontSize)
        
        label = UILabel(frame: CGRect(x: frame.width/2-339/2, y: 0, width: 339, height: 115))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = fontObj
        label.textColor = UIColor.white
        
        //let textInput: UITextField = UITextField(frame: textInputRect)
        textInput.frame = textInputRect
        textInput.textAlignment = .center
        textInput.font = fontObj
        addSubview(textInput)
        addSubview(label)

        alpha = 0.50
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
    
    func keypadDigitPressed(_ digitPressed: String) {
        textInput.text = textInput.text! + digitPressed
    }
    
    func keypadClear() {
        textInput.text = ""
        //phoneNumber = ""
    }
    


}
