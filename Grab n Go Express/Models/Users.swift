//
//  UserModel.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

class User {
    
    var phoneNumber: String = ""
    var passcode: String = ""
    var bAuthenticated: Bool = false
    
    func userAuthenticated(phoneNumber: String, passcode: String)
    {
        self.phoneNumber = phoneNumber
        self.passcode = passcode
        bAuthenticated = true
    }
    
    func userLoggedOff()
    {
        phoneNumber = ""
        passcode = ""
        bAuthenticated = false
    }
}