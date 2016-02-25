//
//  UpdateCardControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 11/9/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class UpdateCardControl: RegisterUserControl {

        /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init (frame : CGRect) {
        
        super.init(frame : frame)
        
        label.text = "Update Your Credit Card"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
