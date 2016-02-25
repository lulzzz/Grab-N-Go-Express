//
//  PaymentOptionsView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/29/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

protocol PaymentOptionsDelegate{
    func reloadAccount(reloadAmount: Double)
}

class PaymentOptionsView: UIController {

    var delegate : PaymentOptionsDelegate?
    
    let formatter = NSNumberFormatter()
    
    var addFiveButton: UIButton = UIButton()
    var addTenButton: UIButton = UIButton()
    
    var logo: UIImageView = UIImageView()
    
    var cartTotal: Double = 0.00
    
    init(cartTotal: Double)
    {
        self.cartTotal = cartTotal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        setBackgroundImage("background_brown.png")
        
        addFiveButton = addButton("big_button.png", action: "reloadFiveDollars", text: "$5", font: "Archer-Bold", fontSize: 91.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 341, textColor: 0x80392C)
        
        let fancyTextFive = FancyTextControl(frame: CGRectMake(0, 0, addFiveButton.frame.width, addFiveButton.frame.height))
        var xPos: CGFloat = 140
        fancyTextFive.addText("$", font: "Archer-Bold", size: 77, color: 0x80392C, x: xPos, y: 0)
        fancyTextFive.addText("5", font: "Archer-Bold", size: 105, color: 0x80392C, x: xPos+37, y: 0)
        fancyTextFive.addText(".25", font: "Archer-Bold", size: 44, color: 0x80392C, x: xPos+83, y: 20)
        let labelFive: UILabel = fancyTextFive.addText("INCLUDES 25$ SERVICE FEE", font: "Archer-Bold", size: 22, color: 0x80392C, x: 0, y: addFiveButton.frame.height - 42)
        labelFive.textAlignment = .Center
        labelFive.frame.size.width = addFiveButton.frame.width
        addFiveButton.titleLabel?.removeFromSuperview()
        fancyTextFive.userInteractionEnabled = false
        addFiveButton.addSubview(fancyTextFive)

  
        addTenButton = addButton("big_button.png", action: "reloadTenDollars", text: "$10", font: "Archer-Bold", fontSize: 91.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 546, textColor: 0x80392C)
        

        let fancyTextTen = FancyTextControl(frame: CGRectMake(0, 0, addFiveButton.frame.width, addFiveButton.frame.height))
        xPos = 130
        fancyTextTen.addText("$", font: "Archer-Bold", size: 77, color: 0x80392C, x: xPos, y: 0)
        fancyTextTen.addText("10", font: "Archer-Bold", size: 105, color: 0x80392C, x: xPos+37, y: 0)
        let labelTen: UILabel = fancyTextTen.addText("NO SERVICE FEE WITH THIS OPTION", font: "Archer-Bold", size: 22, color: 0x80392C, x: 0, y: addFiveButton.frame.height - 42)
        labelTen.textAlignment = .Center
        labelTen.frame.size.width = addFiveButton.frame.width
        addTenButton.titleLabel?.removeFromSuperview()
        fancyTextTen.userInteractionEnabled = false
        addTenButton.addSubview(fancyTextTen)
        
        var cartTotalDisplay = cartTotal;
        // Charge Amount
        if(cartTotalDisplay<10)
        {
            cartTotalDisplay = cartTotalDisplay + 0.50
        }
        
        let amountDue: String = formatter.stringFromNumber(cartTotalDisplay)!
        print(amountDue)
        let fancyTextChargeExact = FancyTextControl(frame: CGRectMake(0, 0, addFiveButton.frame.width, addFiveButton.frame.height))
        
        let chargeExactButton = addButton("big_button.png", action: "chargeExactAmount", text: amountDue, font: "Archer-Bold", fontSize: 91.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 747, textColor: 0x80392C)
        
        
        let labelChargeExact: UILabel = fancyTextChargeExact.addText("$0.50 FEE WITH THIS CHOICE", font: "Archer-Bold", size: 18, color: 0x80392C, x: 0, y: addFiveButton.frame.height - 42)
        labelChargeExact.textAlignment = .Center
        labelChargeExact.frame.size.width = addFiveButton.frame.width
        chargeExactButton.addSubview(fancyTextChargeExact)
        fancyTextChargeExact.userInteractionEnabled = false
        
        logo = addStaticImage("logo.png", xPos: 0, yPos: 50, xPosW: 0, yPosW: 225, width: 166, height: 163, widthW: 275, heightW: 275)
        logo.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
        
        addStaticLabel("PAYMENT OPTIONS", font: "CardenioModern-Bold", fontSize: 60, xPos: 272, yPos: 174, width: 400, height: 70, xPosW: 272, yPosW: 154, widthW: 400, heightW: 70, textColor: 0xFFFFFF)
        
        var instructionsText = UILabel();
        instructionsText = addStaticLabel("Transfer money onto your market account", font: "CardenioModern-Bold", fontSize: 27, xPos: 272, yPos: 174, width: 400, height: 40, xPosW: 272, yPosW: 200, widthW: 400, heightW: 45, textColor: 0xFFFFFF)
        instructionsText.textAlignment = .Justified
    
    }

    func reloadFiveDollars()
    {
        print("Reloading $5.25")
        delegate?.reloadAccount(5.00)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func reloadTenDollars()
    {
        print("Reloading $10.00")
        delegate?.reloadAccount(10.00)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func chargeExactAmount()
    {
        //print("Reloading /())
        delegate?.reloadAccount(cartTotal)
        dismissViewControllerAnimated(true, completion: nil)
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
