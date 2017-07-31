//
//  InventoryControl.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 11/26/16.
//  Copyright © 2016 Adam Arthur. All rights reserved.
//

import Foundation

class InventoryControl : UIView, SBSScanDelegate {
    
    let kScanditBarcodeScannerAppKey = "C/EsedTPMacbZvmTSgUAIkyMQ/BTXEmgEKPYyj4PfHs";
    var picker : SBSBarcodePicker = SBSBarcodePicker()
    
 
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        createControl()
    }
    
    func initCameraScanner()
    {
        SBSLicense.setAppKey(kScanditBarcodeScannerAppKey);
        picker = SBSBarcodePicker(settings:SBSScanSettings.pre47Default())
        picker.scanDelegate = self;
        picker.view.isHidden = false
        picker.view.alpha = 1.0
        addSubview(picker.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createControl()
    {
        initCameraScanner()
        picker.view.frame = frame
    }
    
    /* Delegate Function Implementations */
    
    /* This is the delegate function for the camera-based barcode scanned */
    func barcodePicker(_ picker: SBSBarcodePicker!, didScan session: SBSScanSession!) {
        
        let barcodes_scanned: Array = session.newlyRecognizedCodes
        let barcode: SBSCode = barcodes_scanned[0] as! SBSCode;
        let product: Product = Product()
        product.barcode = barcode.data

    }
}
