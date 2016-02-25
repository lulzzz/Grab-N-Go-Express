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
    var balance: Double = 0.00
    var accountOperator: String = ""
    
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
    
    func toDictionary() -> Dictionary<String, AnyObject>
    {
        var rVal: Dictionary = Dictionary<String, AnyObject>()
        rVal["phone_num"] = phoneNumber
        rVal["passcode"] = passcode
        rVal["balance"] = balance
        rVal["operator"] = accountOperator
        return rVal
    }
}