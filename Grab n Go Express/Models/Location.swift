//
//  Location.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/16/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import Foundation

class Location {
    var location_identifier: String = ""
    var usat_username: String = ""
    var usat_password: String = ""
    var usat_serial: String = ""
    var location_name: String = ""
    var location_taxRate: Double = 0.00
    
}

class GPSCoordinates {
    var latitude: Double = 0
    var longitude: Double = 0
}