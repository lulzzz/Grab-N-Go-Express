//
//  BillValidatorCntroller.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/29/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import Foundation

/*
    This file implements a SIMPLE implementation of the MEI Retail EBDS Serial Protocol.
 
    What is the EBDS Serial Protocol?  Simply put, it's a serial protocol that allows
    for the control of currency acceptors.  Currently, this protocol supports the
    MEI Series 2000 acceptors.
 
    http://www.meigroup.com/global/americas/transport/transport_products/bill_acceptors/series_2000/
 
    I do NOT make the representation that this is a proper implementation of the protocol.
    I do NOT have access to the documentation regarding how this protocol works -- I've had 
    to reverse engineer it.
 
    Why was this necessary?  Quite simply, no libraries exist for Mac or iOS, and since this is
    an iOS application, I needed to make it.
 
    How it works
 
    First, to get this to work, you need to establish a physical connection between the iDevice
    and the Validator.
 
    This is accomplished by using a RedPark Lighting to Serial Cable.
 
    Getting communication working with that is a pain in the ass for a swift project, and I'll
    document it elsewhere.
 
    I was able to find SOME documentation online, from some Chinese site.  But for the most part
    I had to reverse engineer the protocol from using a port sniffer and a few other means.
 
 
 
*/