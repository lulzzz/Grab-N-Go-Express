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
    private var totalAmountDue: Double = 0.00
    
    func addProduct(product: Product)
    {
        products.append(product)
        totalAmountDue += product.totalCost()
    }
    
    func totalCartValue() -> Double
    {
        return totalAmountDue
    }
    // Removes a Product based on the barcode
    func removeProduct(product: Product)
    {
        for i in 0..<products.count
        {
            if(products[i].barcode==product.barcode)
            {
                products.removeAtIndex(i)
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
    
    func countOfBarcode(barcode: String) -> Int
    {
        var barcodeCount: Int = 0
        for i in 0..<products.count
        {
            if(products[i].barcode == barcode)
            {
                ++barcodeCount
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
        ar["count"] = countOfBarcode(products[i].barcode)
        ar["item"] = products[i].toDictionary()
        productsDictionary[products[i].barcode] = ar
       }
        rVal["cart_items"] = productsDictionary
        rVal["total_due"] = totalAmountDue
        rVal["item_count"] = products.count
        return rVal
    }
}