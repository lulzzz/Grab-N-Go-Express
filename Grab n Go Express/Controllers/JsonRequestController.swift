//
//  JsonRequestController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class JsonRequestController: NetworkRequestController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func standardErrors() -> String
    {
        return ""
    }

    func errorExit(parameter: String) -> Bool
    {
        return true
    }
    
    func checkPin(phoneNumber: String, passcode: String) -> Bool
    {
        // Format the json request and notify as needed
        return true
    }
    
    /*
    func error(errorDescription: String) -> String
    {
        // Translate the error into a JSON response and return it.
        
    }
    */
}
