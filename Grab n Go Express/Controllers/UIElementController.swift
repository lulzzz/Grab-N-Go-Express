//
//  UIElementController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

/******************************************************

UIElementController

Handles internationalization

*//////////////////////////////////////////////////////

import UIKit

class UIElementController: UIViewController {

    var supportedLanguages = ["English", "Spanish", "French", "Vietnamese"];
    var defaultLanguage = "English";
    var currentLanguage = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentLanguage = defaultLanguage;
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
