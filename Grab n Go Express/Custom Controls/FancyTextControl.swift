//
//  FancyTextControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/29/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class FancyTextControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init (frame : CGRect) {
        super.init(frame : frame)
        
        
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
    
    func addText(_ text: String, font: String, size: CGFloat, color: UInt, x: CGFloat, y: CGFloat) -> UILabel
    {
        let label = UILabel()
        label.text = text;
        label.font = UIFont(name: font, size: size)
        label.textColor = UIColorFromRGB(color)
        label.frame.origin.x = x
        label.frame.origin.y = y
        label.numberOfLines = 0
        label.sizeToFit()
        addSubview(label)
        return label
    }
}
