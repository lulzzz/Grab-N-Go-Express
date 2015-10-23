//
//  UIElementController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

/******************************************************

UIElementController

This class is intended to simplify the programmatic creation of UIElements.

I created this class for several reasons: 

1.  I don't like using Storyboard to create my UI's.  I'd rather create the UI
in code.  This is a personal preference.  I really dislike using Storyboard for
creating my UI's.

2.  There are many things I like about Swift, but there are many things I dislike.
Creating common UI element's is too many lines of code

FUNCTIONS

createBackground
createButton
createImage
createText
createTable

PARAMETERS

xPos
yPos
width
height
vCenter
hCenter



*//////////////////////////////////////////////////////

import UIKit

class UIElementController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
