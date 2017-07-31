//
//  ShoppingCartControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit


protocol ShoppingCartControlDelegate{
    func itemAdded(_ product: Product)
    func itemRemoved(_ product: Product)
    func updateCartTotal(_ shoppingCart: ShoppingCart)
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
        
        
        backgroundColor = UIColor.clear
        separatorStyle = UITableViewCellSeparatorStyle.none
        
        delegate      =   self
        dataSource    =   self
        
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clear
        return clearView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = dequeueReusableCell(withIdentifier: "cell")!
        
        let bkColor = UIColor(red: 196/255, green: 209/255, blue: 148/255, alpha: 1.0)
        cell.textLabel?.text = self.items[indexPath.section] 
        cell.backgroundColor = bkColor
        cell.textLabel?.font = UIFont(name: "Arial", size: 26)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            shoppingCartDelegate?.itemRemoved(products[indexPath.section])
            items.remove(at: indexPath.section)
            products.remove(at: indexPath.section)
            updateCartTotal()
            
            reloadData()
            //deleteRowsAtIndexPaths([indexPath],  withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func addProduct(_ product: Product)
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let priceString = formatter.string(from: NSNumber(value: product.price))
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

