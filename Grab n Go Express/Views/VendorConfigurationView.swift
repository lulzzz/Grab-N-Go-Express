//
//  VendorConfigurationView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 1/30/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import UIKit

class VendorConfigurationView: ConfigurationView {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingList = [  "There is a problem with your account setup",
            "This page allows you to fix configuration errors",
            "The username and password that you received from USA Technologies",
            "Needs to be double checked and entered here",
            "If you do not know what your USAT username/password is",
            "Contact technical support"]
        
        view.addSubview(locationSerial)
        view.addSubview(locationUsername)
        
        // Fetch the current username / password combo.
    }
}