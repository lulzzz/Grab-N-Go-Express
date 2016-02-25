//
//  Inventory.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 11/10/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

class Inventory {
    var product = Product()
    var parMin: Int = 0
    var parMax: Int = 0
    var quantityOnShelf: Int = 0
    var expectedQuantityOnShelf: Int = 0
    var shelfDescription: String = ""
    var itemPositionOnShelf = 0;
    /*
        itemPositionOnShelf is the physical position of the item on the shelf
        going from left to right, top to bottom.  
    */
}