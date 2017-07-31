//
//  ItemLookup.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 4/22/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import Foundation

// Struct or class?  I think a struct

class ItemLookup {

    var itemTable = [String: String]()
    
    
    func addItem(_ barcode: String, description: String)
    {
        itemTable[barcode] = description
    }
     
    func getItem(_ position: Int) -> (String, String)
    {
        return ("555", "Apple");
    }
    
}
