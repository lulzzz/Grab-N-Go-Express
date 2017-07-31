//
//  AdministrationView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 8/26/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import UIKit

class AdministrationView: UIController {
    /*
            {
                "Administrator":true,
                "customer_id":premierservices,
                "priviledges":{
                    "items":true,
                    "inventory":true
                }

            }
    */
    
    var changePricesButton: AnimatedButton = AnimatedButton();
    var startTheftDetectionButton: AnimatedButton = AnimatedButton();
    var performInventoryButton: AnimatedButton = AnimatedButton();
    var addItemButton: AnimatedButton = AnimatedButton()
    var expireItemsButton: AnimatedButton = AnimatedButton()
    
    var inventoryControl: InventoryControl = InventoryControl();
    
    enum ControlState {
        case change_PRICES
        case theft_DETECTION
        case perform_INVENTORY
        case add_ITEMS
        case expire_ITEMS
        case none
    }
    
    var controlState: ControlState = .none
    
    override func addButton(_ action: Selector) -> AnimatedButton
    {
        let button   = AnimatedButton(type: UIButtonType.system) as AnimatedButton
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.backgroundColor = UIColor.green
        button.setTitle("Button", for: UIControlState())
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        return button
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initCameraScanner()
        
        inventoryControl.backgroundColor = UIColor.blue
        inventoryControl.isHidden = true
        view.addSubview(inventoryControl)
        
        setBackgroundImage("background_green.png")
        addCancelButton()
        
        changePricesButton = addButton("background_button_@1x.png", action: #selector(AdministrationView.changePrices), text: "Change Prices", font: "Archer-Bold", fontSize: 25.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C) as! AnimatedButton
        
        bottomY = bottomY + 150
        
        startTheftDetectionButton = addButton("background_button_@1x.png", action: #selector(AdministrationView.changePrices), text: "Start Theft Detection", font: "Archer-Bold", fontSize: 25.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C) as! AnimatedButton
        
        bottomY = bottomY - 300
        
        performInventoryButton = addButton("background_button_@1x.png", action: #selector(AdministrationView.changePrices), text: "Perform Inventory", font: "Archer-Bold", fontSize: 25.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C) as! AnimatedButton
        
        bottomY = bottomY + 450
        
        addItemButton = addButton("background_button_@1x.png", action: #selector(AdministrationView.addNewItem), text: "Add New Item", font: "Archer-Bold", fontSize: 25.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C) as! AnimatedButton
        
        bottomY = bottomY + 150;
        
        expireItemsButton  = addButton("background_button_@1x.png", action: #selector(AdministrationView.expireItems), text: "Expire Items", font: "Archer-Bold", fontSize: 25.0, xPos: 0.00, yPos: bottomY/2-40, xPosW: 0, yPosW: bottomY/2-40, textColor: 0x80392C) as! AnimatedButton
        
    }
    
    func expireItems()
    {
        controlState = .expire_ITEMS
        animateButtons()
    }
    
    func addNewItem()
    {
        controlState = .add_ITEMS
        animateButtons()
    }
    
    func startTheftDetection()
    {
        controlState = .theft_DETECTION
        animateButtons()
        // Start the theft detection process
    }
    
    func changePrices()
    {
        controlState = .change_PRICES
        animateButtons()
        // Display screen to change prices
    }

    var bShowButtons: Bool = true;
    
    func animateButtons()
    {
        bShowButtons = !bShowButtons;
        if(bShowButtons == false)
        {
            hideButtons()
        }
        else
        {
            showButtons()
        }
    }
    
    func hideButtons()
    {
        UIView.animate(withDuration: 0.5, delay: 0.5,
                                   options: .curveEaseOut, animations: {
                              
            let buttonWidth = self.performInventoryButton.frame.width
                                    
            let xOffset = buttonWidth;
                                    
            self.performInventoryButton.originalXPos = self.performInventoryButton.frame.origin.x
            self.performInventoryButton.frame.origin.x = self.view.frame.width + CGFloat(xOffset);
                                    
            self.changePricesButton.originalXPos = self.changePricesButton.frame.origin.x
            self.changePricesButton.frame.origin.x = CGFloat(xOffset * -1)
                                    
            self.startTheftDetectionButton.originalXPos = self.startTheftDetectionButton.frame.origin.x
            self.startTheftDetectionButton.frame.origin.x = self.view.frame.width + CGFloat(150)
                    
            self.addItemButton.originalXPos = self.addItemButton.frame.origin.x
            self.addItemButton.frame.origin.x = CGFloat(xOffset * -1)
                                    
            self.expireItemsButton.originalXPos = self.expireItemsButton.frame.origin.x
            self.expireItemsButton.frame.origin.x = self.view.frame.width + CGFloat(150)
                                    
            }, completion: {_ in
                self.showCameraScanner()
            }
        )
    }
    
    var bCameraScannerVisible = false;
    
    func showCameraScanner()
    {
        bCameraScannerVisible = !bCameraScannerVisible;
        
        UIView.animate(withDuration: 0.5, delay: 0.0,
                                   options: .curveEaseOut, animations: {
                                    
            if(self.bCameraScannerVisible == true)
            {
                self.inventoryControl.frame = CGRect(x: self.view.frame.width/2-(150), y: 25, width: 300, height: 300)
                                    self.inventoryControl.isHidden = false;
                
                self.inventoryControl.picker.startScanning()
            }
            else
            {
                self.inventoryControl.frame = CGRect(x: self.view.frame.width/2, y: 25+150, width: 0, height: 0)
                self.inventoryControl.picker.stopScanning()
            }
                
                                    
            }, completion: {_ in
                
            }
        )
        
    }
    func showButtons()
    {
        controlState = .none
        
        UIView.animate(withDuration: 0.5, delay: 0.5,
                                   options: .curveEaseOut, animations: {
                                    
                                    
        self.changePricesButton.frame.origin.x = self.changePricesButton.originalXPos
        
        self.startTheftDetectionButton.frame.origin.x = self.startTheftDetectionButton.originalXPos
        
        self.performInventoryButton.frame.origin.x = self.performInventoryButton.originalXPos
        
        self.addItemButton.frame.origin.x = self.addItemButton.originalXPos
        
        self.expireItemsButton.frame.origin.x = self.expireItemsButton.originalXPos
                                    
            }, completion: {_ in
                self.showCameraScanner()
            }
        )
    }
    
    override func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
