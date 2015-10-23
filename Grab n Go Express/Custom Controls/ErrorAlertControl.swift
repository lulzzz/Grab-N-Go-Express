//
//  ErrorAlertControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol ErrorControlDelegate{
    optional func errorOK()
    optional func errorCancel()
}

class ErrorAlertControl: UIView {

    var delegate: ErrorControlDelegate?
    
    let okButton   = UIButton(type: UIButtonType.System) as UIButton
    let cancelButton   = UIButton(type: UIButtonType.System) as UIButton
    let label = UILabel()
    
    override init (frame : CGRect) {
        
        
        super.init(frame : frame)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
        backgroundColor = UIColor.whiteColor()
        //layer.cornerRadius = 10.0
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
        let btnWidth: CGFloat = 210
        let btnHeight: CGFloat = 52
        let btnSpacing: CGFloat = 5
        
        
        okButton.frame = CGRectMake(self.frame.width/2-btnWidth/2-btnWidth/2-btnSpacing, self.frame.height-btnHeight-btnSpacing-25, btnWidth, btnHeight)
        okButton.backgroundColor = UIColor.whiteColor()
        okButton.layer.borderColor = UIColor.blackColor().CGColor
        okButton.layer.borderWidth = 1.00
        okButton.setTitle("OK", forState: UIControlState.Normal)
        okButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        okButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 50.0)
        okButton.addTarget(self, action: "ok", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(okButton)
        
        cancelButton.frame = CGRectMake(self.frame.width/2-btnWidth/2+btnWidth/2+btnSpacing, self.frame.height-btnHeight-btnSpacing-25, btnWidth, 50)
        cancelButton.backgroundColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
        cancelButton.setTitle("CANCEL", forState: UIControlState.Normal)
        cancelButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36.0)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(cancelButton)
        
        label.backgroundColor = UIColor.clearColor()
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.font =  UIFont(name: "CardenioModern-Bold", size: 61.0)
        label.textColor = UIColor.blackColor()
        addSubview(label)
        superview?.alpha = 0.00
        //superview?.alpha = 0.50
        
    }

    convenience init(errorText: String)
    {
        self.init(frame: CGRect.zero)
        label.text = errorText
        print(errorText)
    }
    
    func centerCancelButtonAnimated()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.label.alpha = 1.0
                self.cancelButton.alpha = 1.0
                self.cancelButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                self.okButton.alpha = 0.0
            }, completion: nil)
    }
    
    func centerOKButtonAnimated()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.label.alpha = 1.0
                self.cancelButton.alpha = 0.0
                self.okButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                self.okButton.alpha = 1.0
            }, completion: nil)
    }
    
    func ok()
    {
        delegate?.errorOK!()
        removeFromSuperview()
    }
    
    func cancel()
    {
        delegate?.errorCancel!()
        removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
