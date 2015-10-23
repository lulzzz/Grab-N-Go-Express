//
//  ConfigurationView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/21/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class ConfigurationView: UIController {

    var locationSerial: UITextField = UITextField()
    var locationUsername: UITextField = UITextField()
    var locationPassword: UITextField = UITextField()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        locationSerial = UITextField(frame: CGRect(x: 50, y:50, width: view.frame.width-200, height: 50))
        locationSerial.borderStyle = .RoundedRect
        locationSerial.backgroundColor = UIColor.whiteColor()
        locationSerial.placeholder = "Location Serial"
        
        locationUsername = UITextField(frame: CGRect(x: 50, y: 125, width: view.frame.width-200, height: 50))
        locationUsername.borderStyle = .RoundedRect
        locationUsername.backgroundColor = UIColor.whiteColor()
        locationUsername.placeholder = "Location Username"
        
        view.addSubview(locationSerial)
        view.addSubview(locationUsername)
        
        var button = UIButton(frame: CGRect(x: 50, y: 185, width: view.frame.width-200, height: 50))
        
        button.backgroundColor = UIColor.clearColor()
        
        button.titleLabel?.textAlignment = .Center
        
        button.setTitle("Save Initial Configuration Settings", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel!.font =  UIFont(name: "Arial", size: 30.0)
        
        button.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
    }

    func save()
    {
        // Save the configuration info here
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(locationSerial.text, forKey: "location_serial")
        defaults.setObject(locationUsername.text, forKey: "location_username")
        view.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
