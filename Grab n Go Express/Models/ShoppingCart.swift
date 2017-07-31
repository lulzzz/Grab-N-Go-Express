//
//  ShoppingCart.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/27/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

class ShoppingCart {
    
    // Declare an empty array of products
    var products: [Product] = []
    
    var totalItemsInCart: Int = 0
    fileprivate var totalAmountDue: Double = 0.00
    
    func addProduct(_ product: Product)
    {
        products.append(product)
        totalAmountDue += product.totalCost()
    }
    
    func totalCartValue() -> Double
    {
        return totalAmountDue
    }
    // Removes a Product based on the barcode
    func removeProduct(_ product: Product)
    {
        for i in 0..<products.count
        {
            if(products[i].barcode==product.barcode)
            {
                products.remove(at: i)
                totalAmountDue -= product.totalCost()
                break
            }
        }
    }
    
    func empty()
    {
        products.removeAll()
        totalAmountDue = 0.00
        totalItemsInCart = 0
    }
    
    func countOfBarcode(_ barcode: String) -> Int
    {
        var barcodeCount: Int = 0
        for i in 0..<products.count
        {
            if(products[i].barcode == barcode)
            {
                barcodeCount += 1
            }
        }
        return barcodeCount
    }
    
    func toDictionary() -> Dictionary<String, AnyObject>
    {
        var rVal: Dictionary = Dictionary<String, AnyObject>()
        
        var productsDictionary: Dictionary = Dictionary<String, AnyObject>()

       for i in 0..<products.count
       {
        var ar: Dictionary = Dictionary<String, AnyObject>()
        ar["count"] = countOfBarcode(products[i].barcode) as AnyObject
        ar["item"] = products[i].toDictionary() as AnyObject
        productsDictionary[products[i].barcode] = ar as AnyObject?
       }
        rVal["cart_items"] = productsDictionary as AnyObject?
        rVal["total_due"] = totalAmountDue as AnyObject?
        rVal["item_count"] = products.count as AnyObject?
        return rVal
    }
}
