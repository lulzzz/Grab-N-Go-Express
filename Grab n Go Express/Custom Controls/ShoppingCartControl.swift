//
//  ShoppingCartControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit


protocol ShoppingCartControlDelegate{
    func itemAdded(product: Product)
    func itemRemoved(product: Product)
    func updateCartTotal(shoppingCart: ShoppingCart)
    func cartCleared()
}

class ShoppingCartControl: UITableView, UITableViewDelegate, UITableViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var shoppingCartDelegate:ShoppingCartControlDelegate?
    
    var items: [String] = []
    //var products: [Product] = []
    var products = [Product]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
       super.init(frame: frame, style: style)
        
        
        backgroundColor = UIColor.clearColor()
        separatorStyle = UITableViewCellSeparatorStyle.None
        
        delegate      =   self
        dataSource    =   self
        
        registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clearColor()
        return clearView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = dequeueReusableCellWithIdentifier("cell")!
        
        let bkColor = UIColor(red: 196/255, green: 209/255, blue: 148/255, alpha: 1.0)
        cell.textLabel?.text = self.items[indexPath.section] 
        cell.backgroundColor = bkColor
        cell.textLabel?.font = UIFont(name: "Arial", size: 26)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            shoppingCartDelegate?.itemRemoved(products[indexPath.section])
            items.removeAtIndex(indexPath.section)
            products.removeAtIndex(indexPath.section)
            updateCartTotal()
            
            reloadData()
            //deleteRowsAtIndexPaths([indexPath],  withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func addProduct(product: Product)
    {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let priceString = formatter.stringFromNumber(product.price)
        let insertString: String = product.description + "\t\t\t" + priceString!
        items.append(insertString)
        
        products.append(product)

        shoppingCartDelegate?.itemAdded(product)
        updateCartTotal()
        reloadData()
    }
    
    func clear()
    {
        products.removeAll()
        items.removeAll()
        updateCartTotal()
        reloadData()
        shoppingCartDelegate?.cartCleared()
    }
    
    func updateCartTotal()
    {
        let shoppingCart = ShoppingCart()
        var cartTotal: Double = 0.00
        for i in 0..<products.count
        {
            cartTotal += products[i].price

            for (tax, _) in products[i].tax
            {
                cartTotal += products[i].tax[tax]!
            }
        }
        shoppingCart.totalItemsInCart = products.count
        shoppingCartDelegate?.updateCartTotal(shoppingCart)
    }
}

