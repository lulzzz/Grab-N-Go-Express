//
//  TransactionModel.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

class Transaction{
    
    // Declare a shopping cart object
    var shoppingCart: ShoppingCart = ShoppingCart()
    
    // Declare an empty user
    var user: User = User()
    
    // Declare an empty location
    var location: Location = Location()
    
    // Create a datetime to record when the transaction happened
    var date_time: NSDate = NSDate()
    
    var bSuccessfullTransaction: Bool = false
    // Both successfull and unsuccessful transactions are recorded
    
    func  toDictionary() -> Dictionary<String, AnyObject>
    {
        var rVal: Dictionary = Dictionary<String, AnyObject>()
        rVal["shopping_cart"] = shoppingCart.toDictionary()
        rVal["user"] = user.toDictionary()
        
        // Shopping Cart
        //rVal["cart_items"] = shoppingCart.products.toDictionary()
        
        return rVal
    }
}