//
//  ErrorAlertControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/18/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol ErrorControlDelegate{
    @objc optional func errorOK()
    @objc optional func errorCancel()
}

class ErrorAlertControl: UIView {

    var delegate: ErrorControlDelegate?
    
    let okButton   = UIButton(type: UIButtonType.system) as UIButton
    let cancelButton   = UIButton(type: UIButtonType.system) as UIButton
    let label = UILabel()
    
    override init (frame : CGRect) {
        
        
        super.init(frame : frame)
        
        let screenSize: CGRect = UIScreen.main.bounds
        
// If we're in an iPad
if(UIDevice.current.userInterfaceIdiom == .pad)
{
self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
label.font =  UIFont(name: "CardenioModern-Bold", size: 61.0)
}
else
{
// If we're in an iPhone
self.frame = CGRect(x: 0, y: screenSize.height/2-screenSize.height/4, width: screenSize.width, height: screenSize.height/2)
label.font =  UIFont(name: "CardenioModern-Bold", size: 30.0)
}

        //self.frame = CGRect(x: 0, y: screenSize.height/3, width: screenSize.width, height: screenSize.height/3)
        backgroundColor = UIColor.white
        //layer.cornerRadius = 10.0
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        
        let btnWidth: CGFloat = 210
        let btnHeight: CGFloat = 52
        let btnSpacing: CGFloat = 5
        
        
        okButton.frame = CGRect(x: self.frame.width/2-btnWidth/2-btnWidth/2-btnSpacing, y: self.frame.height-btnHeight-btnSpacing-25, width: btnWidth, height: btnHeight)
        okButton.backgroundColor = UIColor.white
        okButton.layer.borderColor = UIColor.black.cgColor
        okButton.layer.borderWidth = 1.00
        okButton.setTitle("OK", for: UIControlState())
        okButton.setTitleColor(UIColor.black, for: UIControlState())
        okButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 50.0)
        okButton.addTarget(self, action: #selector(ErrorAlertControl.ok), for: UIControlEvents.touchUpInside)
        addSubview(okButton)
        
        cancelButton.frame = CGRect(x: self.frame.width/2-btnWidth/2+btnWidth/2+btnSpacing, y: self.frame.height-btnHeight-btnSpacing-25, width: btnWidth, height: 50)
        cancelButton.backgroundColor = UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
        cancelButton.setTitle("CANCEL", for: UIControlState())
        cancelButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36.0)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState())
        cancelButton.addTarget(self, action: #selector(ErrorAlertControl.cancel), for: UIControlEvents.touchUpInside)
        addSubview(cancelButton)
        
        if(UIDevice.current.userInterfaceIdiom == .phone)
        {
            // If we're in an iPhone
            //self.frame = CGRect(x: 0, y: screenSize.height/2-screenSize.height/4, width: screenSize.width, height: screenSize.height/2)
            //label.font =  UIFont(name: "CardenioModern-Bold", size: 30.0)
            
            //label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2)
            
            okButton.frame = CGRect(x: self.frame.width/2-btnWidth/2, y: self.frame.height-btnHeight-btnSpacing-btnHeight-5, width: btnWidth, height: btnHeight)
            
            cancelButton.frame = CGRect(x: self.frame.width/2-btnWidth/2, y: self.frame.height-btnHeight-btnSpacing, width: btnWidth, height: btnHeight)
        }
        
        label.backgroundColor = UIColor.clear
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        addSubview(label)
        superview?.alpha = 0.00
        //superview?.alpha = 0.50
        
    }

    convenience init(errorText: String)
    {
        self.init(frame: CGRect.zero)
        label.text = errorText
    }
    
    func centerCancelButtonAnimated()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
                self.label.alpha = 1.0
                self.cancelButton.alpha = 1.0
                self.cancelButton.frame = CGRect(x: self.frame.width/2-self.cancelButton.frame.width/2, y: self.cancelButton.frame.origin.y, width: self.cancelButton.frame.width, height: self.cancelButton.frame.height)
                self.okButton.alpha = 0.0
            }, completion: nil)
    }
    
    func centerOKButtonAnimated()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0,
            options: .curveEaseOut, animations: {
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
