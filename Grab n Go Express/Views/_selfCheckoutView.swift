//
//  _selfCheckoutView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/29/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

/* This class is called to format the elements for iPhones */

import UIKit

class _selfCheckoutView: SelfCheckoutView {

    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    
    override func viewDidLoad() {
        
        self.view = self.scrollView
        
        // setup the scroll view
        self.scrollView.contentSize = CGSize(width:view.frame.width, height: view.frame.height*2)
        
        super.viewDidLoad()

        scanbycamera()
        // Do any additional setup after loading the view.
    }
    
    override func setBackgroundImage(imageName: String)
    {
        var screenSize: CGRect = UIScreen.mainScreen().bounds
        screenSize.size.width = screenSize.width*2
        screenSize.size.height = screenSize.height*2
        
        let backgroundImage = UIImage(named: imageName)
        let imageView = UIImageView(image: backgroundImage)
        imageView.frame = screenSize
        self.backgroundImageView = imageView
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rechargeAccount()
    {
        errorAlertView.removeFromSuperview()
        let view = _paymentOptionsView(cartTotal: shoppingCart.totalCartValue())
        view.delegate = self
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    override func scanbycamera()
    {
        
        //let distance: CGFloat = 300
        
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                
                let logoYPos: CGFloat = 20
                let logoHeight: CGFloat = 20
                let logoWidth: CGFloat = 20
                
                self.logo.hidden = true
                
                self.logo.frame.origin.x = 25
                self.logo.frame.origin.y = 25
                self.logo.frame.size.width = logoWidth
                self.logo.frame.size.height = logoHeight
                
                self.scanitemsbelow.alpha = 0.0
                self.scanitemstext.alpha = 0.0
                
                self.shoppingCartControl.frame.origin.x = 0
                self.shoppingCartControl.frame.size.width = self.view.frame.width
                self.shoppingCartControl.frame.size.height = 150
                
                self.balanceAvailableButton.frame.origin.x = 0
                self.amountDueButton.frame.origin.x = 0
                self.paynowButton.frame.origin.x = 0
                self.balanceAvailableLabel.frame.origin.x = 0
                self.amountDueLabel.frame.origin.x = 0
                
                self.paynowLabel.frame.origin.x = self.view.frame.midX-self.paynowLabel.frame.midX
                self.paynowButton.frame.origin.x = self.view.frame.width/2-self.paynowButton.frame.width/2
                self.paynowButton.frame.origin.y = self.view.frame.maxY-self.paynowButton.frame.height
                print(self.paynowButton.frame)
                if(self.paynowButton.frame.origin.y<612)
                {
                    self.paynowButton.frame.origin.y = 612
                }
                
                self.balanceAvailableButton.frame.size.width = self.view.frame.width/2-20
                self.balanceAvailableButton.frame.origin.x = 0
                self.balanceAvailableButton.frame.origin.y = self.paynowButton.frame.origin.y - self.balanceAvailableButton.frame.height-5
                self.amountDueButton.frame.size.width = self.view.frame.width/2-20
                self.amountDueButton.frame.origin.x = self.view.frame.width - self.amountDueButton.frame.width
                self.amountDueButton.frame.origin.y = self.paynowButton.frame.origin.y - self.balanceAvailableButton.frame.height-5
                
     
                self.balanceAvailableLabel.frame.size.width = self.view.frame.width/2-20
                self.balanceAvailableLabel.frame.origin.x = 0
                self.balanceAvailableLabel.frame.origin.y = self.paynowButton.frame.origin.y - self.balanceAvailableButton.frame.height-45
                self.amountDueLabel.frame.size.width = self.view.frame.width/2-20
                self.amountDueLabel.frame.origin.x = self.view.frame.width - self.amountDueButton.frame.width
                self.amountDueLabel.frame.origin.y = self.paynowButton.frame.origin.y - self.balanceAvailableButton.frame.height-45
                
                self.scanItemInstructionsLabel.frame.origin.x = 0

                self.scanItemInstructionsLabel.hidden = true

                
                self.scanItemInstructionsLabel.frame.size.width = self.view.frame.width
                self.scanItemInstructionsLabel.frame.size.height = 150
                self.scanItemInstructionsLabel.frame.origin.x = 0
                self.scanItemInstructionsLabel.text = "Hold Items in front of camera to scan"
                self.scanItemInstructionsLabel.textAlignment = .Center
                self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 50)
                
                self.shoppingCartControl.frame.origin.x = 0
                
                
                self.logoutButton.frame.size.width = self.view.frame.width/3.4-10
                self.logoutButton.frame.size.height = 40
                self.logoutButton.frame.origin.y = logoYPos + logoHeight+5
                self.logoutButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2
                self.logoutButton.titleLabel!.font = UIFont(name: "Arial", size: 16)
    
                self.updateCardButton.frame.size.width = self.view.frame.width/3.4-10
                self.updateCardButton.frame.size.height = 40
                self.updateCardButton.frame.origin.y = logoYPos + logoHeight+5
                self.updateCardButton.frame.origin.x = 15
                self.updateCardButton.titleLabel!.font = UIFont(name: "Arial", size: 16)
                
                self.cancelOrderButton.frame.size.width = self.view.frame.width/3.4-10
                self.cancelOrderButton.frame.size.height = 40
                self.cancelOrderButton.frame.origin.y = logoYPos + logoHeight+5
                self.cancelOrderButton.frame.origin.x = self.view.frame.width-self.cancelOrderButton.frame.width-15
                self.cancelOrderButton.titleLabel!.font = UIFont(name: "Arial", size: 16)
                
                
                self.scanByCameraButton.alpha = 0
                //logo.alpha = 0
                //self.logo.frame = CGRect(x: 0, y: 0, width: 275, height: 275)
                
            }, completion: {_ in
                
                UIView.animateWithDuration(1.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        
                        self.picker.view.frame = CGRect(
                            x: self.view.center.x-CGFloat(275/2),
                            y: self.cancelOrderButton.frame.maxY+15, width: 275, height: 275)
                        self.picker.view.hidden = false
                        self.picker.view.alpha = 1.0
                        self.shoppingCartControl.frame.origin.y = self.picker.view.frame.maxY + 15
                        
                    }, completion: {_ in
                        self.picker.startScanning()
                        self.picker.overlayController.setViewfinderHeight(Float(self.view.center.x)-Float(275/2), width: 275, landscapeHeight: 275, landscapeWidth: 275)
                })
                
                
            }
            
        )
    }
    
    override func logout()
    {
       super.logout()
    }
    
    override func thankYouAnimation()
    {
        super.thankYouAnimation()
        
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: .CurveEaseOut, animations: {
                
                self.doneButton.frame = CGRect(x: self.doneButton.frame.origin.x, y: self.view.frame.height - self.doneButton.frame.height-25, width: self.doneButton.frame.width, height: self.doneButton.frame.height)

            }, completion: nil)
    }
    
    override func login(user: User) {
        super.login(user)
        setBaseParameters(user)
    }
    
    /* This is a delegate called by the shopping cart control after an item is successfully added to the cart */
    override func itemAdded(product: Product)
    {
        
        
        let yPositionChange: CGFloat = 45
        
        
        
        self.balanceAvailableButton.frame.origin.y = self.balanceAvailableButton.frame.origin.y + yPositionChange
        self.balanceAvailableLabel.frame.origin.y = self.balanceAvailableLabel.frame.origin.y + yPositionChange
        
        self.shoppingCartControl.frame.size.height = self.self.balanceAvailableLabel.frame.origin.y-self.shoppingCartControl.frame.origin.y-5
        
        self.amountDueButton.frame.origin.y = self.amountDueButton.frame.origin.y + yPositionChange
        self.amountDueLabel.frame.origin.y = self.amountDueLabel.frame.origin.y + yPositionChange
        
        self.paynowButton.frame.origin.y = self.paynowButton.frame.origin.y + yPositionChange
        self.paynowLabel.frame.origin.y = self.paynowLabel.frame.origin.y + yPositionChange
        
        //self.shoppingCartControl.frame.size.height =  self.shoppingCartControl.frame.height + yPositionChange
        //self.shoppingCartControl.backgroundColor = UIColor.whiteColor()
        //self.shoppingCartControl.alpha = 0.50
        
        super.itemAdded(product)
        
        if(product.barcode=="10000000020")
        {
            // A special barcode that allows people to do inventory
            let inventoryView = _inventoryViewViewController()
            inventoryView.setBaseParameters(user)
            user.userAuthenticated(phoneNumber, passcode: user.passcode)
            user.balance = user.balance
            user.accountOperator = user.accountOperator
            inventoryView.view.backgroundColor = UIColor.whiteColor()
            inventoryView.login(user)
            inventoryView.user = user
            self.presentViewController(inventoryView, animated: true, completion: nil)
        }
        
        // For the iPhone version, I want to "push" the buttons down.
        /*
        
        self.amountDueButton.frame.origin.x = 0
        self.paynowButton.frame.origin.x = 0
        self.balanceAvailableLabel.frame.origin.x = 0
        self.amountDueLabel.frame.origin.x = 0
        
        self.paynowLabel.frame.origin.x = self.view.frame.midX-self.paynowLabel.frame.midX
        self.paynowButton.frame.origin.x = self.view.frame.width/2-self.paynowButton.frame.width/2
        self.paynowButton.frame.origin.y = self.view.frame.maxY-self.paynowButton.frame.height
        */
    }
}
