//
//  AnimatedApprovalControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class AnimatedApprovalControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var progressView: UIProgressView?
    var progressLabel: UILabel?
    
    var registration: Registration = Registration()
    
    var first_nameLabel = UILabel(frame: CGRect(x: 65, y: 65, width: 150, height: 165))
    var completing_registrationLabel = UILabel()
    var last_nameLabel = UILabel()
    var cc_infoLabel = UILabel()
    var zipcodeLabel = UILabel()
    var ccvLabel = UILabel()
    var phoneNumberLabel = UILabel()
    var passcodeLabel = UILabel()
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    // I want to create an animated approval
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        // Create a circle shape
        
        ovalShapeLayer.strokeColor = UIColor.redColor().CGColor
        ovalShapeLayer.fillColor = UIColor.blueColor().CGColor
        ovalShapeLayer.lineWidth = 4.0
        //ovalShapeLayer.lineDashPattern = [2, 3]
        let refreshRadius: CGFloat = 100
        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: frame.size.width/2 - refreshRadius,
            y: frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius)).CGPath
        //layer.addSublayer(ovalShapeLayer)
        
        hidden = true
        completing_registrationLabel.text = "Completing Registrations"
        completing_registrationLabel.frame = CGRect(x: 0, y: 0,
            width: frame.width,
            height: frame.height)
        completing_registrationLabel.textAlignment = .Center
        //addSubview(completing_registrationLabel)
        
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        progressView?.frame = CGRectMake(25, frame.height - 100, frame.width-50, 100)
        addSubview(progressView!)
        
        // Add Label
        progressLabel = UILabel()
        let frame = CGRectMake(center.x - 25, frame.height - 50, frame.width-50, 50)
        progressLabel?.frame = frame
        //addSubview(progressLabel!)
        
        NSTimer.scheduledTimerWithTimeInterval(0.10, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
        
    }
    
    func updateProgress() {
        progressView?.progress += 0.01
        let progressValue = self.progressView?.progress
        progressLabel?.text = "\(progressValue! * 100) %"
    }
    
    var progress: CGFloat {
        get {
            return ovalShapeLayer.strokeEnd
        }
        set {
            if (newValue > 1) {
                ovalShapeLayer.strokeEnd = 1
            } else if (newValue < 0) {
                ovalShapeLayer.strokeEnd = 0
            } else {
                ovalShapeLayer.strokeEnd = newValue
            }
        }
    }
    
    convenience init(frame: CGRect, registration: Registration)
    {
        self.init(frame: frame)
        self.registration = registration

        //first_nameLabel.textColor = UIColor.blackColor()
        //first_nameLabel.textAlignment = .Left
        first_nameLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        first_nameLabel.numberOfLines = 0
        
        last_nameLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        phoneNumberLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        passcodeLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        zipcodeLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        ccvLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        cc_infoLabel.font =  UIFont(name: "CardenioModern-Bold", size: 48.0)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
        
    func animateIn(){
        // Animated the entire frame in
        let oldFrame = frame
        let newFrame = CGRect(x: 0, y: frame.height/2, width: frame.width, height: 0)
        frame = newFrame
        hidden = false
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.frame = oldFrame
                
            }, completion:
                {_ in
                    
                });
        
        
        self.animateRegistrationInfo()
        wobbleLeft()
    }
    
    func animateOut(){
        // Animated the entire frame in
        let newFrame = CGRect(x: 0, y: frame.height/2, width: frame.width, height: 0)
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.frame = newFrame
                self.alpha = 0.0
            }, completion:
            {_ in
                self.removeFromSuperview()
        });
    }
    
    func animateRegistrationInfo()
    {
        let top: CGFloat = 130
        
        //first_nameLabel.text = "Thanks, " + registration.first_name + "\n\nIt'll just be a moment while we complete your registration"
        first_nameLabel.text = "Completing Registration"
        first_nameLabel.textAlignment = .Center
        last_nameLabel.text = registration.last_name
        cc_infoLabel.text = "Card Info: " + registration.cc_info
        zipcodeLabel.text = "Zipcode: " + registration.zipcode
        ccvLabel.text = "CCV: " + registration.ccv
        phoneNumberLabel.text = "Phone Number: " + registration.phoneNumber
        passcodeLabel.text = "Passcode: " + registration.passcode

        first_nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 265)
        last_nameLabel.frame = CGRect(x: 225, y: top, width: 225, height: 65)
        phoneNumberLabel.frame = CGRect(x: 65, y: top*2, width: frame.width, height: 65)
        passcodeLabel.frame = CGRect(x: 65, y: top*3, width: frame.width, height: 65)
        zipcodeLabel.frame = CGRect(x: 65, y: top*4, width: frame.width, height: 65)
        cc_infoLabel.frame = CGRect(x: 65, y: top*5, width: frame.width, height: 65)
        ccvLabel.frame = CGRect(x: 65, y: top*6, width: frame.width, height: 65)
        
        addSubview(first_nameLabel)
        //addSubview(last_nameLabel)
        //addSubview(cc_infoLabel)
        //addSubview(zipcodeLabel)
        //addSubview(ccvLabel)
        //addSubview(phoneNumberLabel)
        //addSubview(passcodeLabel)
        
        progress = 0
    }
    
    var wobble = true
    
    func wobbleLeft() {
        
        _ = UIBezierPath(ovalInRect: CGRect(x: frame.size.width/2 - 100,
            y: frame.size.height/2 - 100,
            width: 0,
            height: 0)).CGPath
        
        UIView.animateWithDuration(6.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                
                //self.backgroundColor = UIColor.blueColor()
                //self.ovalShapeLayer.fillColor = UIColor.redColor().CGColor
                //self.ovalShapeLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                // Animate the next element that needs to be shown
                //self.passcodeControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.passcodeControl.frame.origin.y, width: self.passcodeControl.frame.width, height: self.passcodeControl.frame.height)
                //self.advanceState()
                
            }, completion: nil);
    }
    
    
    
    func wobbleRight() {
        
        if !wobble {
            return
        }
        
       let path = UIBezierPath(ovalInRect: CGRect(x: frame.size.width/2 - 100,
            y: frame.size.height/2 - 100,
            width: 2 * 100,
            height: 2 * 100)).CGPath
        
        UIView.animateWithDuration(10.0, animations: { () -> Void in
            self.ovalShapeLayer.opacity = 1.00
            self.ovalShapeLayer.path = path
            }) { (finished) -> Void in
                self.wobbleLeft()
        }
    }
}
