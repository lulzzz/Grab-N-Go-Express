//
//  UIElements.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

extension UIControl
{
    /*
    var xPos: CGFloat = 0.00
    var yPos: CGFloat = 0.00
    var width: CGFloat = 0.00
    var height: CGFloat = 0.00
    
    // The convention is W stands for Wide Screen - iPads, in other words
    var xPosW: CGFloat = 0.00
    var yPosW: CGFloat = 0.00
    var widthW: CGFloat = 0.00
    var heightW: CGFloat = 0.00
    */
    
    func setBackgroundImage(imageName: String)
    {
            let backgroundImage = UIImage(named: imageName)
            let imageView = UIImageView(image: backgroundImage)
            self.addSubview(imageView)

    }
    // We'll set property observers for the Wide Screen elements
}

