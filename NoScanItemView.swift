//
//  NoScanItemView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 4/7/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import UIKit

protocol NoScanItemDelegate{
    func itemTypedIn(_ barcode: String)
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
        barcodeControl.isHidden = false
        barcodeControl.textInput.keyboardType = .numberPad
        barcodeControl.alpha = 1.0
        barcodeControl.frame = CGRect(x: self.screenSize.width/2-barcodeControl.frame.width/2, y: barcodeControl.frame.origin.y, width: barcodeControl.frame.width, height: barcodeControl.frame.height)
        
        shoppingCartDelegate = self
                
        //instructionLabel.alpha = 1.0
        
        view.addSubview(barcodeControl)

        tableView.frame = CGRect(x: 25, y: 25, width: view.frame.width-50, height: 100)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
        dismiss(animated: true, completion: nil)
    }
    
    /*  This actually adds the product into the shoppingCartControl */
    func barcodeScanned(_ product: Product)
    {
        //shoppingCartControl.addProduct(product)
    }
    
    func itemLookup(_ itemList: ItemLookup)
    {
        items.removeAll()
        self.itemList.removeAll()
        for (key, value) in itemList.itemTable {
            items.append(value)
            self.itemList[value] = key
        }
        tableView.reloadData()
        
    }
    
    
    func keypadDigitPressed(_ digitPressed: String)
    {
        print(digitPressed)
    }
    
    func listItems(_ barcode: String)
    {
        itemLookup(barcode);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.items.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell

        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        delegate?.itemTypedIn(itemList[items[row]]!)
        cancel()
    }
}
