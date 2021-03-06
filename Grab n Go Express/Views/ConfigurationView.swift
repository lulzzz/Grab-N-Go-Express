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
    
    var timer: Timer!
    
    var noAccountLabel: UILabel!
    var i = 0
    
    var logoView: UIImageView!
    var saveSettingsButton: UIButton = UIButton()
    
    var shoppingList: [String] = [  "Welcome to the Market",
                                    "Please wait while we determine your location",
                                    "Grab, Scan and Pay with this App",
                                    "Grab n Go Market makes it easy",
                                    "Almost Done",
                                    "Location Found"]
    
    var manualEntry = UIButton()
    
    override func viewDidAppear(_ animated: Bool)
    {

        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 18, target:self, selector: #selector(ConfigurationView.animateInstructions), userInfo: nil, repeats: true)
        
        //UIView.animateWithDuration(0.5, delay: 15,
        //    options: .CurveEaseOut, animations:
        //    {
                //
        
        manualEntry.backgroundColor = UIColor.white
        
        UIView.animate(withDuration: 2.5, delay: 7,
            options: .curveEaseOut, animations: {
                self.logoView.frame.origin.y = self.view.frame.height-self.logoView.frame.height-12
                self.picker.view.frame = CGRect(x: 25, y: 25, width: self.view.frame.width-50, height: 185)
                
                
                self.picker.view.alpha = 0.0
            }, completion: {_ in
              
                UIView.animate(withDuration: 0.5, delay: 0,
                    options: .curveEaseOut, animations: {
                        /*
                        self.picker.view.hidden = false
                        self.picker.view.alpha = 1.0
                        self.noAccountLabel.frame.origin.y = self.picker.view.frame.origin.y
                        self.picker.startScanning()
                        self.manualEntry.frame = self.noAccountLabel.frame
                        self.manualEntry.frame.origin.y = self.picker.view.frame.origin.y + self.picker.view.frame.height+12
                        self.manualEntry.frame.size.height = 35
                        self.manualEntry.frame.size.width = self.manualEntry.frame.width - 50
                        self.manualEntry.frame.origin.x = 25
                        self.manualEntry.layer.borderWidth = 1.0
                        self.manualEntry.setTitleColor(UIColor.blackColor(), forState: .Normal)
                        self.manualEntry.setTitle("Manual Entry", forState: .Normal)
                        self.manualEntry.addTarget(self, action: "manual", forControlEvents: UIControlEvents.TouchUpInside)
                        self.noAccountLabel.frame.origin.y = self.manualEntry.frame.maxY+25
                        
                        self.noAccountLabel.textColor = UIColor.blackColor()
                        self.noAccountLabel.frame.size.height = 120
                        self.noAccountLabel.backgroundColor = UIColor.whiteColor()
                        self.view.addSubview(self.manualEntry)
                        */
                    }, completion: nil)
                
            })
                

        
    }
    
    var myRect = CGRect()
    
    func manual()
    {
        timer.invalidate()
        view.addSubview(locationSerial)
        locationSerial.keyboardType = .numberPad
        locationSerial.frame = CGRect(x: 100, y: 100, width: view.frame.width-200, height: 40)
        myRect = CGRect(x: 100, y: 100, width: view.frame.width-200, height: 40)
        saveSettingsButton.isHidden = true
        view.addSubview(saveSettingsButton)
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations:
            {
                self.noAccountLabel.alpha = 0.0
                self.picker.view.alpha = 0.0
                self.locationSerial.alpha = 1.0
                self.manualEntry.alpha = 0.0
                self.saveSettingsButton.alpha = 0.0
                
            }, completion:
            {(Bool) in
                
                UIView.animate(withDuration: 0.5, delay: 0,
                    options: .curveEaseOut, animations: {
                        self.manualEntry.isHidden = true
                        self.saveSettingsButton.frame = self.manualEntry.frame
                        self.saveSettingsButton.isHidden = false
                        self.saveSettingsButton.alpha = 1.0
                        self.locationSerial.becomeFirstResponder()
                        //self.noAccountLabel.text = self.shoppingList[self.i]
                        //self.noAccountLabel.alpha = 1.0
                    }, completion: nil)
        })
    }

    func animateInstructions()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations:
            {
                self.noAccountLabel.alpha = 0.0
                
            }, completion:
            {(Bool) in
                
                UIView.animate(withDuration: 0.5, delay: 1,
                    options: .curveEaseOut, animations: {
                        self.noAccountLabel.text = self.shoppingList[self.i]
                        self.noAccountLabel.alpha = 1.0
                    }, completion: nil)
        })
        i += 1
        
        if(i>4)
        {
            i = 4
        }
    }

/*
let timeDelay = 0.5;

var cumulativeDelay = 6.0

//let multiplier: Double = 1;//cumulativeDelay

//for i in 0..<4
//{
//cumulativeDelay = Double(i) * multiplier
//print(cumulativeDelay)


UIView.animateWithDuration(timeDelay, delay: 12.0,
options: .CurveEaseOut, animations:
{
//self.noAccountLabel.alpha = 0.0

}, completion:
{(Bool) in

UIView.animateWithDuration(timeDelay, delay: 1,
options: .CurveEaseOut, animations: {
//self.noAccountLabel.text = self.shoppingList[1]
//self.noAccountLabel.alpha = 1.0
}, completion: nil)


})

//}
*/
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundImage("background_blue.png")

        logoView = addStaticImage("logo.png", xPos: 0, yPos: 30, xPosW: 0, yPosW: 225, width: 166, height: 163, widthW: 275, heightW: 275)

        noAccountLabel = addStaticLabel("Welcome to the Market", font: "CardenioModern-Bold", fontSize: 38, xPos: 0, yPos: 0, width: view.frame.width, height: view.frame.height, xPosW: 0, yPosW: 0, widthW: 200, heightW: 150, textColor: 0xFFAAFF)



        //UIView.animateWithDuration(0.5, delay: 10.0,
        //    options: .CurveEaseOut, animations: {
        //        noAccountLabel.text = "First, we need to know which market you are at."
        //    }, completion: nil)
        
        locationSerial = UITextField(frame: CGRect(x: 50, y:50, width: view.frame.width-200, height: 50))
        locationSerial.borderStyle = .roundedRect
        locationSerial.backgroundColor = UIColor.white
        locationSerial.placeholder = "Location Serial"
        
        locationUsername = UITextField(frame: CGRect(x: 50, y: 125, width: view.frame.width-200, height: 50))
        locationUsername.borderStyle = .roundedRect
        locationUsername.backgroundColor = UIColor.white
        locationUsername.placeholder = "Location Username"
                
        let button: UIButton = UIButton(frame: CGRect(x: 50, y: 185, width: view.frame.width-200, height: 50))
        
        button.backgroundColor = UIColor.clear
        
        button.titleLabel?.textAlignment = .center
        
        button.setTitle("Save", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel!.font =  UIFont(name: "Arial", size: 30.0)
        button.layer.borderWidth = 1.9
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(ConfigurationView.save), for: UIControlEvents.touchUpInside)
        
        saveSettingsButton = button
        //view.addSubview(button)
        
        
        /*
        
        self.scanditBarcodePicker = [[SBSBarcodePicker alloc]
        initWithSettings:[SBSScanSettings pre47DefaultSettings]];
        
[self addChildViewController:self.scanditBarcodePicker];
[self.view addSubview:self.scanditBarcodePicker.view];
[self.scanditBarcodePicker didMoveToParentViewController:self];
        */
        
        
        addChildViewController(picker)
        picker.view.frame = CGRect(x: 0, y: 0, width: view.frame.width-200, height: 100)
        view.addSubview((picker.view))
        picker.view.isHidden = true
        picker.didMove(toParentViewController: self)
        //picker?.startScanning()
    }

    func save()
    {
        // Save the configuration info here
        //let defaults = NSUserDefaults.standardUserDefaults()
        
        //defaults.setObject(locationSerial.text, forKey: "location_serial")
        
        UserDefaults.standard.setValue(locationSerial.text, forKey: "location_serial")
        
        //view.removeFromSuperview()
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func barcodePicker(_ picker: SBSBarcodePicker!, didScan session: SBSScanSession!) {
        //let defaults = NSUserDefaults.standardUserDefaults()
        
        
        //defaults.setObject(locationSerial.text, forKey: "location_serial")
        UserDefaults.standard.setValue(locationSerial.text, forKey: "location_serial")

        dismiss(animated: true, completion: nil)
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
