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
    
    func userAuthenticated(_ phoneNumber: String, passcode: String)
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
        rVal["phone_num"] = phoneNumber as AnyObject?
        rVal["passcode"] = passcode as AnyObject?
        rVal["balance"] = balance as AnyObject?
        rVal["operator"] = accountOperator as AnyObject?
        return rVal
    }
}
