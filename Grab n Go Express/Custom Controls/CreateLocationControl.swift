//
//  CreateLocationControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 11/27/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import Foundation

class CreateLocationControl : WizardControl {
    
    enum createLocationState{
        case justStarted
        case locationName
        case signupBonus
        case taxRate
    }
    
    var currentState: createLocationState = .justStarted
    var justStartedText: String = "Creating a Location is Quick and Easy\nIt takes less than a minute"
    let locationNameText = "What is the name of this location?"
    let signupBonusText = "How Much Is the Signup Bonus?"
    let taxRateText = "What is the Tax Rate of this location?"
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}