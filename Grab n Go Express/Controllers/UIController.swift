//
//  UIController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class UIController : ApiRequestController, ErrorControlDelegate, SBSScanDelegate
{
    // This class is responsible for handling the formatting differences
    // between iPads and iPhones
    
    let kScanditBarcodeScannerAppKey = "C/EsedTPMacbZvmTSgUAIkyMQ/BTXEmgEKPYyj4PfHs";
    
    var picker : SBSBarcodePicker = SBSBarcodePicker()

    
    // I'm interested in storing the device type to manage the position of elements
    // depending on which device we're on.  This may be unnecessary, I'm still learning
    // about IOS adapative layouts.  But I hate storyboard, so all of my UI is going to
    // be created in code.  This is not the best way of doing this -- it won't play
    // nice with future devices.  More research...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SBSLicense.setAppKey(kScanditBarcodeScannerAppKey);
        picker = SBSBarcodePicker(settings:SBSScanSettings.pre47DefaultSettings())
        picker.scanDelegate = self;
        picker.view.hidden = true
        picker.view.alpha = 0.0
        view.addSubview(picker.view)
    }
    
    func barcodePicker(picker: SBSBarcodePicker!, didScan session: SBSScanSession!) {
    
    }
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    enum deviceType {
            case iPad
            case iPadMini
            case iPhone
            case iPhone3
            case iPhone4
            case iPhone5
            case iPhone6
            case iPhone6Plus
            case unsupportedDevice
            case simulator
    }
    
    
    // http://stackoverflow.com/questions/26028918/ios-how-to-determine-iphone-model-in-swift
    var currentDevice: deviceType {
        
        // For development only.
       // return deviceType.iPhone4
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            return deviceType.iPad
        }
        else
        {
            return deviceType.iPhone
        }
        /*
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("")
            {
                identifier, element in
                guard let value = element.value as? Int8 where value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        
        
        switch identifier {
        case "iPod5,1":                                 return deviceType.iPhone4
        case "iPod7,1":                                 return deviceType.iPhone4
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return deviceType.iPhone4
        case "iPhone4,1":                               return deviceType.iPhone4
        case "iPhone5,1", "iPhone5,2":                  return deviceType.iPhone5
        case "iPhone5,3", "iPhone5,4":                  return deviceType.iPhone5
        case "iPhone6,1", "iPhone6,2":                  return deviceType.iPhone5
        case "iPhone7,2":                               return deviceType.iPhone6
        case "iPhone7,1":                               return deviceType.iPhone6Plus
        case "iPhone8,1":                               return deviceType.iPhone6
        case "iPhone8,2":                               return deviceType.iPhone6Plus
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return deviceType.iPad
        case "iPad3,1", "iPad3,2", "iPad3,3":           return deviceType.iPad
        case "iPad3,4", "iPad3,5", "iPad3,6":           return deviceType.iPad
        case "iPad4,1", "iPad4,2", "iPad4,3":           return deviceType.iPad
        case "iPad5,1", "iPad5,3", "iPad5,4":           return deviceType.iPad
        case "iPad2,5", "iPad2,6", "iPad2,7":           return deviceType.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return deviceType.iPadMini
        case "iPad4,7", "iPad4,8", "iPad4,9":           return deviceType.iPadMini
        case "iPad5,1", "iPad5,2":                      return deviceType.iPadMini
        case "i386", "x86_64":                          return deviceType.simulator
        default:                                        return deviceType.unsupportedDevice
        }
        */
    }
    
    var backgroundColor: UIColor = UIColor()
    var backgroundImageView: UIImageView = UIImageView()
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat)
    {
        
        let backgroundColor = UIColor(
            red: red/255.0,
            green: green/255.0,
            blue: blue/255.0,
            alpha: opacity)
        
        self.backgroundColor = backgroundColor
        self.view.backgroundColor = backgroundColor
    }
    
    func switchBackgroundColorAnimated(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat)
    {
        // In case we want to switch the background color in a fun, animated way
    }
    
    func setBackgroundImage(imageName: String)
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let backgroundImage = UIImage(named: imageName)
        let imageView = UIImageView(image: backgroundImage)
        imageView.frame = screenSize
        self.backgroundImageView = imageView
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func rotateView(degrees: CGFloat, theView: UIView)
    {
        
        //theView.transform = CGAffineTransformMakeRotation(degrees*M_PI/180);
        theView.transform = CGAffineTransformMakeRotation(degrees)
        //theView.transform = transform
    }
    
    func switchBackgroundImageAnimated(imageName: String)
    {
       // In case we want to switch the background image in a fun, animated way
    }
    
    enum genericPositions {
        case topLeft
        case topCenter
        case topRight
        case middleLeft
        case middleCenter
        case middleRight
        case bottomLeft
        case bottomCenter
        case bottomRight
    }
    
    func addButton(action: Selector) -> UIButton
    {
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, 50, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Button", forState: UIControlState.Normal)
        button.addTarget(self, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        return button
    }
    
    func addButton(action: Selector, xPos: CGFloat, yPos: CGFloat)
    {
    
    }
    
    func addButton(action: Selector, backgroundImage: String)
    {
        
    }
    
    
    func addButton(backgroundImage: String, action: Selector, text: String, font: String, fontSize: CGFloat,
        var x: CGFloat,
        var y: CGFloat,
        width: CGFloat,
        height: CGFloat, textColor: UInt) -> UIButton
    {
        
        // If xPos, yPos, etc is ZERO, then we calculate the center for the screen.
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, width, height)); // set as you want
        let image = UIImage(named: backgroundImage);
        imageView.image = image;
       
        let button: UIButton = addButton(action)
        button.setBackgroundImage(imageView.image, forState: .Normal)
        
        if(x == 0)
        {
            x = screenSize.width/2-imageView.frame.width/2
            //width = screenSize.width/2-imageView.frame.width/2
        }
        
        if(y == 0)
        {
            y = screenSize.height/2-imageView.frame.height/2
            //height = screenSize.height/2-imageView.frame.height/2
            
        }
        
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        // This sets the size of the button to the size of the image
        
        if(currentDevice == deviceType.iPad)
        {
            button.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        
        button.backgroundColor = UIColor.clearColor()
        
        button.titleLabel?.textAlignment = .Center
        button.setTitle(text, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel!.font =  UIFont(name: font, size: fontSize)
        button.setTitleColor(UIColorFromRGB(textColor), forState: .Normal)
        button.titleLabel!.textColor = UIColorFromRGB(textColor)
        return button
    }
    
    func addButton(backgroundImage: String, action: Selector, text: String, font: String, fontSize: CGFloat, var xPos: CGFloat, var yPos: CGFloat, var xPosW: CGFloat, var yPosW: CGFloat, textColor: UInt) -> UIButton
    {
        
        // If xPos, yPos, etc is ZERO, then we calculate the center for the screen.
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        let image = UIImage(named: backgroundImage)
        let imageView = UIImageView(image: image)
        
        let button: UIButton = addButton(action)
        button.setBackgroundImage(backgroundImage)
        
        if(xPos == 0)
        {
            xPos = screenSize.width/2-imageView.frame.width/2
            xPosW = screenSize.width/2-imageView.frame.width/2
        }
        
        if(yPos == 0)
        {
            yPos = screenSize.height/2-imageView.frame.height/2
            yPosW = screenSize.height/2-imageView.frame.height/2
            
        }
        
        button.frame = CGRect(x: xPos, y: yPos, width: imageView.frame.width, height: imageView.frame.height)
        // This sets the size of the button to the size of the image
        
        if(currentDevice == deviceType.iPad)
        {
            button.frame = CGRect(x: xPosW, y: yPosW, width: imageView.frame.width, height: imageView.frame.height)
        }
        
        button.backgroundColor = UIColor.clearColor()
        
        button.titleLabel?.textAlignment = .Center
        button.setTitle(text, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel!.font =  UIFont(name: font, size: fontSize)
        button.setTitleColor(UIColorFromRGB(textColor), forState: .Normal)
        button.titleLabel!.textColor = UIColorFromRGB(textColor)
        return button
    }
    
    func addButton(action: Selector, text: String, parentButton: UIButton, backgroundImage: String, var xOffset: CGFloat, var yOffset: CGFloat, xOffsetW: CGFloat, yOffsetW: CGFloat) -> UIButton
    {

        if(currentDevice != deviceType.iPad)
        {
        if(xOffset != 0)
        {
            xOffset = parentButton.frame.origin.x+xOffset+parentButton.frame.width
        }
        else
        {
            xOffset = parentButton.frame.origin.x
        }
        
        if(yOffset != 0)
        {
            yOffset = parentButton.frame.origin.y+yOffset+parentButton.frame.height            
        }
        else
        {
            yOffset = parentButton.frame.origin.y+yOffset
        }
        }
        
        
        if(currentDevice == deviceType.iPad)
        {
            
            if(xOffset != 0)
            {
                xOffset = parentButton.frame.origin.x+xOffsetW+parentButton.frame.width
            }
            else
            {
                xOffset = parentButton.frame.origin.x

            }
            
            if(yOffset != 0)
            {
                yOffset = parentButton.frame.origin.y+yOffsetW+parentButton.frame.height
            }
            else
            {
                yOffset = parentButton.frame.origin.y+yOffsetW
            }
        }

        // Creates a button nearly identical to parent button, but offsets it by the yPos
        let button: UIButton = addButton(action)
        
        let image = UIImage(named: backgroundImage)
        button.setBackgroundImage(image, forState: .Normal)
        button.frame = CGRect(x: xOffset, y: yOffset, width: parentButton.frame.width, height: parentButton.frame.height)
        button.setTitle(text, forState: .Normal)
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel!.font = parentButton.titleLabel?.font
        button.setTitleColor(parentButton.titleLabel?.textColor, forState: .Normal)
        return button
    }
    
    func addStaticImage(imageName: String, var xPos: CGFloat, var yPos: CGFloat, var xPosW: CGFloat, var yPosW: CGFloat, width: CGFloat, height: CGFloat, widthW: CGFloat, heightW: CGFloat) -> UIImageView
    {
        
        if(xPos==0)
        {
            xPos = screenSize.width/2-width/2
        }
        
        if(yPos==0)
        {
            yPos = screenSize.height/2-height/2
        }
        
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        if(currentDevice == deviceType.iPad)
        {
            if(xPosW==0)
            {
                xPosW=screenSize.width/2-widthW/2
            }
            
            if(yPosW==0)
            {
                yPosW=screenSize.height/2-heightW/2
            }
            
            imageView.frame = CGRect(x: xPosW, y: yPosW, width: widthW, height: heightW)
        }
        self.view.addSubview(imageView)
        return imageView
    }
    
    func addStaticLabel(text: String, font: String, fontSize: CGFloat, var xPos: CGFloat, var yPos: CGFloat, width: CGFloat, height: CGFloat, var xPosW: CGFloat, var yPosW: CGFloat, widthW: CGFloat, heightW: CGFloat, textColor: UInt) -> UILabel
        {
            
            let label = UILabel()
            // If xPos, yPos, etc is ZERO, then we calculate the center for the screen.
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            
            if(xPos == 0)
            {
                xPos = screenSize.width/2-width/2
                xPosW = screenSize.width/2-widthW/2
            }
            
            if(yPos == 0)
            {
                yPos = screenSize.height/2-height/2
                yPosW = screenSize.height/2-heightW/2
                
            }
            
            if(currentDevice == deviceType.iPad)
            {
                label.frame = CGRect(x: xPosW, y: yPosW, width: widthW, height: heightW)
            }
            else
            {
                label.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            }
            
            label.backgroundColor = UIColor.clearColor()
            
            label.textAlignment = .Center
            label.text = text
            label.numberOfLines = 0
            label.font =  UIFont(name: font, size: fontSize)
            label.textColor = UIColor.whiteColor()
            
            self.view.addSubview(label)
            
            
            //(UIColor.blackColor())
            return label

    }
    
   
    
    func errorAlert(alertText: String) -> ErrorAlertControl
    {
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: alertText)
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        return errorAlertView
    }
    
    func errorAlert(alertText: String, okText: String, cancelText: String) -> ErrorAlertControl
    {
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: alertText)
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        errorAlertView.okButton.setTitle(okText, forState: .Normal)
        errorAlertView.cancelButton.setTitle(cancelText, forState: .Normal)
        return errorAlertView
    }
    
    func errorOK(){
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.backgroundImageView.alpha = 1.0
            }, completion: nil)
    }
    
    func errorCancel() {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                    self.backgroundImageView.alpha = 1.0
            }, completion: nil)
    }
}