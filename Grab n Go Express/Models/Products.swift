//
//  ProductModel.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

// Struct or class?  I think a struct

class Product {
    var description = ""
    var barcode = "";
    var price: Double = 0.00
    //var tax: Dictionary = Dictionary<String, Double>()
    var tax = [String : Double]()
    //var errorDescriptions = [Int: String]()
    
    // We can have multile tax categories and types
    // For example, California has a sales tax and a fixed
    // unit tax
    
    func totalCost() -> Double
    {
        var totalCost = 0.00
        totalCost = price + totalTax()
        return totalCost
    }
    
    func totalTax() -> Double
    {
        var taxTotal = 0.00
        for (_, taxAmount) in tax {
            taxTotal += taxAmount
        }
        return taxTotal
    }
    
    func toDictionary() -> Dictionary<String, AnyObject>
    {
        var rVal: Dictionary = Dictionary<String, AnyObject>()
        rVal["description"] = description
        rVal["barcode"] = barcode
        rVal["price"] = price
        rVal["tax"] = totalTax()
        return rVal
    }
}