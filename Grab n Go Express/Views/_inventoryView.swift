//
//  _inventoryViewViewController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 11/10/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

// Slider for inventory amount


class _inventoryViewViewController: _selfCheckoutView {

    var inventories: [Inventory] = []
    // Create an array of Inventory() objects
    
    // UI
    var quantityOnShelfSlider: UISlider = UISlider()
    
    // Par Controls
    var parMinStepper: UIStepper = UIStepper()
    var parMaxStepper: UIStepper = UIStepper()
    var parMinStepperLabel: UILabel = UILabel()
    var parMaxStepperLabel: UILabel = UILabel()
    
    // Item Description
    var itemDescriptionLabel: UILabel = UILabel()
    var itemPriceLabel: UILabel = UILabel()
    var itemTaxableBool: UISwitch = UISwitch()
    var inventoryOnShelfLabel: UILabel = UILabel()
    
    // Shelf Description
    var shelfDescriptonLabel: UILabel = UILabel()
    var changeShelfDescriptionButton: UIButton = UIButton()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let font = UIFont(name: "Arial", size: 48)
        paynowButton.removeFromSuperview()
        balanceAvailableButton.removeFromSuperview()
        updateCardButton.removeFromSuperview()
        cancelOrderButton.removeFromSuperview()
        scanItemInstructionsLabel.removeFromSuperview()
        amountDueLabel.removeFromSuperview()
        balanceAvailableLabel.removeFromSuperview()
        amountDueButton.removeFromSuperview()
        
        let startYPos: CGFloat = self.logoutButton.frame.maxY+15+275
        let heightOfControls: CGFloat = 50
        let distanceBetweenControls: CGFloat = 15
        let width = view.frame.width
        let x: CGFloat = 5
        // The picker control's y position is changed by an animation,
        // normally I would reference the maxY position of that view's 
        // frame, but can't do that here.

        itemDescriptionLabel.frame = CGRect(x: 0, y: startYPos, width: width, height: heightOfControls)
        itemDescriptionLabel.text = "Scan The Item To Inventory"
        itemDescriptionLabel.font = font
        itemDescriptionLabel.textAlignment = .center
        view.addSubview(itemDescriptionLabel)
        
        var yPos: CGFloat = startYPos + heightOfControls + distanceBetweenControls

        // This label displays the number of units on the shelf as per the calculated inventory
        inventoryOnShelfLabel.frame = CGRect(x: 0, y: yPos, width: width, height: heightOfControls)
        inventoryOnShelfLabel.text = "0"
        inventoryOnShelfLabel.font = font
        inventoryOnShelfLabel.textAlignment = .center
        
        view.addSubview(inventoryOnShelfLabel)
        
        // Update yPos
        yPos = yPos + heightOfControls + distanceBetweenControls
        
        // This control changes the label above
        quantityOnShelfSlider.frame = CGRect(x: x, y: yPos, width: width-(x*2), height: heightOfControls)
        view.addSubview(quantityOnShelfSlider)
        
        // Update yPos
        yPos = yPos + heightOfControls + distanceBetweenControls
        
        // Steppers
        let widthOfSteppers: CGFloat = 94
        
        // Stepper Labels
        parMinStepperLabel.frame = CGRect(x: x, y: yPos+distanceBetweenControls, width: widthOfSteppers-(x*2), height: heightOfControls)
        parMinStepperLabel.text = "0"
        parMinStepperLabel.textAlignment = .center
        //parMinStepper.font = font
        view.addSubview(parMinStepperLabel)
        
        parMaxStepperLabel.frame = CGRect(x: width-widthOfSteppers-x, y: yPos+distanceBetweenControls, width: widthOfSteppers-(x*2), height: heightOfControls)
        parMaxStepperLabel.textAlignment = .center
        parMaxStepperLabel.text = "0"
        view.addSubview(parMaxStepperLabel)
        
        // Update yPos
        yPos = yPos + heightOfControls + distanceBetweenControls
        
        // Steppers
        parMinStepper.frame = CGRect(x: x, y: yPos, width: widthOfSteppers-(x*2), height: heightOfControls)
        view.addSubview(parMinStepper)
        
        parMaxStepper.frame = CGRect(x: width-widthOfSteppers-x, y: yPos, width: widthOfSteppers-(x*2), height: heightOfControls)
        view.addSubview(parMaxStepper)
        
        
        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItemToInventory(_ product: Product)
    {
        
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
