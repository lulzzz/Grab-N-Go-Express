//
//  AnimatedControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class AnimatedControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

class AnimatedButton : UIButton {
    var originalXPos: CGFloat = 0;
    var originalYPos: CGFloat = 0;
    var originalWidth: CGFloat = 0;
    var originalHeight: CGFloat = 0;
}