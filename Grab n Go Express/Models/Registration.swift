//
//  Registration.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

struct Registration
{
    var first_name: String
    var last_name: String
    var cc_info: String
    var zipcode: String
    var ccv: String
    var phoneNumber: String
    var passcode: String
    var exp_date: String
    
    init()
    {
        first_name = ""
        last_name = ""
        cc_info = ""
        zipcode = ""
        ccv = ""
        phoneNumber = ""
        passcode = ""
        exp_date = ""
    }
}