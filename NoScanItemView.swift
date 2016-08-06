//
//  NoScanItemView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 4/7/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import UIKit

protocol NoScanItemDelegate{
    func itemTypedIn(barcode: String)
}

class NoScanItemView: UIController, KeypadControlDelegate, BarcodeControlDelegate, ApiResultsDelegate, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView();
    
    let barcodeControl: BarcodeControl = BarcodeControl(instructionsText: "Enter the Barcode")
    
    var delegate : NoScanItemDelegate?
    
     var items: [String] = []
    
    var itemList = [String: String]()
    // Can't scan an item for some reason
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage("background_brown.png")
        
        barcodeControl.delegate = self
        barcodeControl.hidden = false
        barcodeControl.textInput.keyboardType = .NumberPad
        barcodeControl.alpha = 1.0
        barcodeControl.frame = CGRect(x: self.screenSize.width/2-barcodeControl.frame.width/2, y: barcodeControl.frame.origin.y, width: barcodeControl.frame.width, height: barcodeControl.frame.height)
        
        shoppingCartDelegate = self
                
        //instructionLabel.alpha = 1.0
        
        view.addSubview(barcodeControl)

        tableView.frame = CGRect(x: 25, y: 25, width: view.frame.width-50, height: 100)
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.dataSource = self
        view.addSubview(tableView)
        // Add Keypad
        // Add instructions
        
        addCancelButton();
        cancelButton.frame.origin.x = view.frame.width/2-cancelButton.frame.width/2
        
        // We want to eliminate...what?
        // if iPhone, display keypad
        // if iPad, display custom keypad
        // 
    }
    
    override func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*  This actually adds the product into the shoppingCartControl */
    func barcodeScanned(product: Product)
    {
        //shoppingCartControl.addProduct(product)
    }
    
    func itemLookup(itemList: ItemLookup)
    {
        items.removeAll()
        self.itemList.removeAll()
        for (key, value) in itemList.itemTable {
            items.append(value)
            self.itemList[value] = key
        }
        tableView.reloadData()
        
    }
    
    
    func keypadDigitPressed(digitPressed: String)
    {
        print(digitPressed)
    }
    
    func listItems(barcode: String)
    {
        itemLookup(barcode);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.items.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell

        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        delegate?.itemTypedIn(itemList[items[row]]!)
        cancel()
    }
}
