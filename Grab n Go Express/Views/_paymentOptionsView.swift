//
//  _paymentOptionsView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/30/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class _paymentOptionsView: PaymentOptionsView {

    override func viewDidLoad() {
        //super.viewDidLoad()

        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        addFiveButton = addButton("big_button.png", action: "reloadFiveDollars", text: "$5", font: "Archer-Bold",
            fontSize: 25.0,
            x: 0.00,
            y: 0.00,
            width: view.frame.width-20,
            height: 100,
            textColor: 0x80392C)
        
        addTenButton = addButton("big_button.png", action: "reloadTenDollars", text: "$10", font: "Archer-Bold",
            fontSize: 25.0,
            x: 0.00,
            y: addFiveButton.frame.origin.y - 110,
            width: view.frame.width-20,
            height: 100,
            textColor: 0x80392C)
        
        var cartTotalDisplay = cartTotal;
        // Charge Amount
        if(cartTotalDisplay<10)
        {
            cartTotalDisplay = cartTotalDisplay + 0.50
        }
        
        let amountDue: String = formatter.stringFromNumber(cartTotalDisplay)!
        
        _ = addButton("big_button.png", action: "reloadTenDollars", text: amountDue, font: "Archer-Bold",
            fontSize: 25.0,
            x: 0.00,
            y: addFiveButton.frame.origin.y + 110,
            width: view.frame.width-20,
            height: 100,
            textColor: 0x80392C)
        addFiveButton.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
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
