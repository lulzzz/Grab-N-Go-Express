//
//  SelfCheckoutView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class SelfCheckoutView: UIController {

    var logo: UIImageView = UIImageView()
    var scanItemInstructionsLabel: UILabel = UILabel()
    var cartItemTable: UITableView = UITableView()
    
    var logoutButton: UIButton = UIButton()
    var priceCheckButton: UIButton = UIButton()
    var cancelOrderButton: UIButton = UIButton()
    var balanceDueButton: UIButton = UIButton()
    var amountDueButton: UIButton = UIButton()
    var paynowButton: UIButton = UIButton()
    
    var user: User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage("background_selfcheckout.png")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(user: User)
    {
        self.user = user
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
