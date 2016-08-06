//
//  SelfCheckoutView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class SelfCheckoutView: UIController, ShoppingCartControlDelegate, ApiResultsDelegate, PaymentOptionsDelegate, NoScanItemDelegate, RegisterUserControlDelegate, DTDeviceDelegate, UITextFieldDelegate {

    /* Our Model Classes */
    var user: User = User()
    var location: Location = Location()
    var transaction: Transaction = Transaction()
    var shoppingCart: ShoppingCart = ShoppingCart()
    
    let formatter = NSNumberFormatter()
    
    var addFiveButton: UIButton = UIButton()
    var addTenButton: UIButton = UIButton()
    
    var doneButton: UIButton = UIButton()
    
    var logo: UIImageView = UIImageView()
    var scanItemInstructionsLabel: UILabel = UILabel()
    var cartItemTable: UITableView = UITableView()
    
    var logoutButton: UIButton = UIButton()
    var updateCardButton: UIButton = UIButton()
    var cancelOrderButton: UIButton = UIButton()
    var accountSettingsButton: UIButton = UIButton()
    var noScanItemButton: UIButton = UIButton()
    
    var balanceAvailableButton: UIButton = UIButton()
    var amountDueButton: UIButton = UIButton()
    var paynowButton: UIButton = UIButton()
    var scanByCameraButton: UIButton = UIButton()

    var balanceAvailableLabel: UILabel = UILabel()
    var amountDueLabel: UILabel = UILabel()
    var paynowLabel: UILabel = UILabel()
    
    var scanitemsbelow: UIImageView = UIImageView()
    var scanitemstext: UIImageView = UIImageView()
    
    var shoppingCartControl: ShoppingCartControl = ShoppingCartControl()
    
    var totalAmountDue = 0.00
    
    var textInput = UITextField()

    var dtdevices: DTDevices = DTDevices()
    
    // -(BOOL)barcodeSetScanMode:(int)mode error:(NSError **)error;
    
    var myInputView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage("background_green.png")
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        // Do any additional setup after loading the view.
        
        //addButton("background_button.png", action: "login", text: "LOGIN", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 210, textColor: 0x80392C)

        balanceAvailableButton.frame = CGRect(x: 55, y: 645, width: 211, height: 55)
        balanceAvailableButton.backgroundColor = UIColor.whiteColor()
        balanceAvailableButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        balanceAvailableButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        view.addSubview(balanceAvailableButton)
        
        amountDueButton.frame = CGRect(x: 55+211+15, y: 645, width: 211, height: 55)
        amountDueButton.backgroundColor = UIColor.whiteColor()
        amountDueButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        amountDueButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        amountDueButton.setTitle(formatter.stringFromNumber(0), forState: .Normal)
        view.addSubview(amountDueButton)
        
        paynowButton.frame = CGRect(x: 55+211+15+211+15, y: 645, width: 211, height: 55)
        paynowButton.backgroundColor = UIColor.redColor()
        paynowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        paynowButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36)
        paynowButton.setTitle("PAY NOW", forState: .Normal)
        paynowButton.addTarget(self, action: "payNowButton", forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(paynowButton)
        
        balanceAvailableLabel.frame = CGRect(x: 55, y: 590, width: 211, height: 55)
        balanceAvailableLabel.text = "Balance"
        balanceAvailableLabel.font = UIFont(name: "Arial", size: 28)
        balanceAvailableLabel.textAlignment = .Center
        view.addSubview(balanceAvailableLabel)
        
        amountDueLabel.frame = CGRect(x: 55+211+15, y: 590, width: 211, height: 55)
        amountDueLabel.text = "Amount Due"
        amountDueLabel.font = UIFont(name: "Arial", size: 28)
        //amountDueLabel.backgroundColor = UIColor.whiteColor()
        amountDueLabel.textAlignment = .Center
        view.addSubview(amountDueLabel)
        
        logo = addStaticImage("logo.png", xPos: 0, yPos: 50, xPosW: 0, yPosW: 225, width: 166, height: 163, widthW: 275, heightW: 275)
        logo.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
        
        self.scanitemsbelow =  addStaticImage("scanitem.png",          xPos: 460, yPos: 720, xPosW: 460, yPosW: 720, width: 166, height: 163, widthW: 247, heightW: 243)
        self.scanitemstext = addStaticImage("scanselections.png",    xPos: 460, yPos: 720, xPosW: 160, yPosW: 715, width: 146, height: 143, widthW: 279, heightW: 256)
        

        scanItemInstructionsLabel = addStaticLabel("SCAN YOUR FIRST ITEM", font: "CardenioModern-Bold", fontSize: 61, xPos: 125, yPos: 400, width: 420, height: 202, xPosW: 250, yPosW: 187, widthW: 500, heightW: 70, textColor: 0xFFAAFF)
        scanItemInstructionsLabel.textAlignment = .Left
        
        let menuButtonColor: UIColor = UIColor(red: 215/255, green: 221/255, blue: 59/255, alpha: 1.0)
        let menuButtonTextColor: UIColor = UIColor(red: 104/255, green: 112/255, blue: 21/255, alpha: 1.0)
        
        logoutButton.frame = CGRect(x: 570, y: 30, width: 175, height: 40)
        logoutButton.setTitle("logout", forState: .Normal)
        logoutButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        logoutButton.backgroundColor = menuButtonColor
        logoutButton.setTitleColor(menuButtonTextColor, forState: .Normal)
        logoutButton.addTarget(self, action: "logout", forControlEvents: .TouchDown)
        view.addSubview(logoutButton)
     
        updateCardButton.frame = CGRect(x: 570, y: 30+40+15, width: 175, height: 40)
        updateCardButton.setTitle("update card", forState: .Normal)
        updateCardButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        updateCardButton.backgroundColor = menuButtonColor
        updateCardButton.setTitleColor(menuButtonTextColor, forState: .Normal)
        updateCardButton.addTarget(self, action: "updatecard", forControlEvents: .TouchDown)
        view.addSubview(updateCardButton)
        
        cancelOrderButton.frame = CGRect(x: 570, y: 30+40+15+40+15, width: 175, height: 40)
        cancelOrderButton.setTitle("item lookup", forState: .Normal)
        cancelOrderButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        cancelOrderButton.backgroundColor = menuButtonColor
        cancelOrderButton.setTitleColor(menuButtonTextColor, forState: .Normal)
        cancelOrderButton.addTarget(self, action: "cancelorder", forControlEvents: .TouchDown)
        view.addSubview(cancelOrderButton)
        
        scanByCameraButton = UIButton(frame: CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50))
        scanByCameraButton.setTitle("Scan By Using the iPad's Camera", forState: .Normal)
        scanByCameraButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        scanByCameraButton.backgroundColor = menuButtonColor
        scanByCameraButton.setTitleColor(menuButtonTextColor, forState: .Normal)
        scanByCameraButton.addTarget(self, action: "scanbycamera", forControlEvents: .TouchDown)
        view.addSubview(scanByCameraButton)
        
        shoppingCartControl.frame = CGRect(x: 51, y: 300, width: 666, height: 300)
        //shoppingCartControl.backgroundColor = UIColor.whiteColor()
        shoppingCartControl.shoppingCartDelegate = self
        view.addSubview(shoppingCartControl)
        
        shoppingCartDelegate = self
        
        dtdevices.addDelegate(self)
        dtdevices.connect()
        //
        do {
            //try dtdevices.barcodeSetScanMode(2)
        } catch _ {
            print("No effect")
        }
        
        /*
        //dtdevices.barcodeSetScanMode:(int)mode error:(NSError **)error;
        try dtdevices.barcodeSetScanMode(1){

    }
    catch {
    print(error)
    
        */
    
        let textInputRect: CGRect = CGRect(x: -339, y: -75, width: 339, height: 75)
        textInput.frame = textInputRect
        textInput.textAlignment = .Center
        textInput.allowsEditingTextAttributes = false
        textInput.backgroundColor = UIColor.redColor()
        textInput.borderStyle = UITextBorderStyle.Line
        textInput.becomeFirstResponder()
        //textInput.autocorrectionType = UITextAutocorrectionType.No
        //textInput.keyboardType = .NumberPad
        textInput.delegate = self
        textInput.inputView = myInputView

        // external_barcode_scanner
        let external_barcode_scanner = NSUserDefaults.standardUserDefaults().boolForKey("external_barcode_scanner")
        
        if(external_barcode_scanner)
        {
            view.addSubview(textInput)
            hideTheAssistantBar(self.view);
        }
        
        Timeout(180.0) { self.logout() }
        
        let camera_by_default = NSUserDefaults.standardUserDefaults().boolForKey("camera_default")
        
        if(camera_by_default)
        {
            scanbycamera()
        }
    }

    func hideTheAssistantBar(view:UIView) {
        //Check this view
        for case let textField as UITextField in view.subviews {
            if #available(iOS 9.0, *) {
                let item : UITextInputAssistantItem = textField.inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            } else {
                // Fallback on earlier versions
            }

        }
        for case let searchBar as UISearchBar in view.subviews {
            if #available(iOS 9.0, *) {
                let item : UITextInputAssistantItem = searchBar.inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            } else {
                // Fallback on earlier versions
            }

        }
        
        //Now find this views subviews
        let subviews = view.subviews
        
        for subview : AnyObject in subviews {
            if subview.isKindOfClass(UIView) {
                hideTheAssistantBar(subview as! UIView)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        balanceAvailableButton.setTitle(formatter.stringFromNumber(user.balance), forState: .Normal)
        setBaseParameters(user)
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

    /* This is a delegate called by the shopping cart control after an item is successfully added to the cart */
    func itemAdded(product: Product)
    {
        shoppingCart.addProduct(product)

    }
    
    /* This is a delegate called by the shopping cart control after an item is removed */
    func itemRemoved(product: Product)
    {
        shoppingCart.removeProduct(product)
    }
    
    func updateCartTotal(shoppingCart: ShoppingCart)
    {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        let amountDue = formatter.stringFromNumber(self.shoppingCart.totalCartValue())
        amountDueButton.setTitle(amountDue, forState: .Normal)
        totalAmountDue = self.shoppingCart.totalCartValue()
    }
    
    func payNowButton()
    {
        //paynowButton.enabled = false
        //paynowButton.alpha = 0.80
        // Construct a Transaction Object
        transaction.shoppingCart = shoppingCart
        transaction.user = user
        transaction.bSuccessfullTransaction = false
        transaction.date_time = NSDate()
        
        print(totalAmountDue)
        print(user.balance)
        if(totalAmountDue <= user.balance)
        {
            transaction.bSuccessfullTransaction = true
            // Submit the transaction to the server, wait for the response
            let accountBalance = user.balance - totalAmountDue
            let accountBalanceString = formatter.stringFromNumber(accountBalance)
            balanceAvailableButton.setTitle(accountBalanceString, forState: .Normal)
            user.balance = accountBalance
            paynowButton.enabled = false
            completeTransaction(transaction)
        }
        else
        {
            // Do a recharge
            errorAlertView = ErrorAlertControl(errorText: "You do not have enough money to complete this transaction")
            errorAlertView.cancelButton.hidden = false
            //backgroundImageView.alpha = 0.50
            errorAlertView.okButton.setTitle("Reload", forState: .Normal)
            //errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
            errorAlertView.okButton.addTarget(self, action: "rechargeAccount", forControlEvents: UIControlEvents.TouchDown)
            self.view.addSubview(errorAlertView)
        }
    }
    
    var errorAlertView: ErrorAlertControl!
    
    func itemTypedIn(barcode: String)
    {
        let product: Product = Product()
        product.barcode = barcode
        itemScanned(product)
    }
    
    func typeBarcodeManually()
    {
        let view = NoScanItemView()
        
        view.setBaseParameters(user)
        
        view.delegate = self
        view.phoneNumber = phoneNumber
        view.passcode = passcode
        
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    func rechargeAccount()
    {
        //clearUIElements()
        errorAlertView.removeFromSuperview()
        let view = PaymentOptionsView(cartTotal: shoppingCart.totalCartValue())
        view.delegate = self
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    /* reloadAccount is a delegate of PaymentOptionsView */
    override func reloadAccount(amount: Double)
    {
        super.reloadAccount(amount)
        // Reloading our account!
    }
    
    func logout()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*  This actually adds the product into the shoppingCartControl */
    func barcodeScanned(product: Product)
    {
        shoppingCartControl.addProduct(product)
    }
    
    func itemLookup(itemList: ItemLookup)
    {
        
    }
    

    /* This is the delegate function for the camera-based barcode scanned */
    override func barcodePicker(picker: SBSBarcodePicker!, didScan session: SBSScanSession!) {
        
        let barcodes_scanned: Array = session.newlyRecognizedCodes
        let barcode: SBSCode = barcodes_scanned[0] as! SBSCode;
        let product: Product = Product()
        product.barcode = barcode.data
        itemScanned(product)
    }
    
    /* This is the delegate function for the physically attached Linea-Pro Barcode Reader */
    func barcodeData(barcode: String!, type: Int32)
    {
        let product: Product = Product()
        product.barcode = barcode
        itemScanned(product)
    }
    
    /*
var logo: UIImageView = UIImageView()
var scanItemInstructionsLabel: UILabel = UILabel()
var cartItemTable: UITableView = UITableView()

var logoutButton: UIButton = UIButton()
var updateCardButton: UIButton = UIButton()
var cancelOrderButton: UIButton = UIButton()

var balanceAvailableButton: UIButton = UIButton()
var amountDueButton: UIButton = UIButton()
var paynowButton: UIButton = UIButton()

var balanceAvailableLabel: UILabel = UILabel()
var amountDueLabel: UILabel = UILabel()
var paynowLabel: UILabel = UILabel()
    */

    func scanbycamera()
    {
        
        let distance: CGFloat = 300
        
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {

        self.logo.frame.origin.y += distance
        
        self.scanitemsbelow.alpha = 0.0
        self.scanitemstext.alpha = 0.0
                
        self.cartItemTable.frame.origin.y += distance
        self.balanceAvailableButton.frame.origin.y += distance
        self.amountDueButton.frame.origin.y += distance
        self.paynowButton.frame.origin.y += distance
        self.balanceAvailableLabel.frame.origin.y += distance
        self.amountDueLabel.frame.origin.y += distance
        self.paynowLabel.frame.origin.y += distance
        self.scanItemInstructionsLabel.frame.origin.y = 25
        self.scanItemInstructionsLabel.frame.size.width = self.view.frame.width
        self.scanItemInstructionsLabel.frame.size.height = 150
        self.scanItemInstructionsLabel.frame.origin.x = 0
        self.scanItemInstructionsLabel.text = "Hold Items in front of camera to scan"
        self.scanItemInstructionsLabel.textAlignment = .Center
        self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 50)
        self.shoppingCartControl.frame.origin.y += distance
                
        self.logoutButton.frame.origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
        self.logoutButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2
        self.updateCardButton.frame.origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
        self.updateCardButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2-self.logoutButton.frame.width-15
        self.cancelOrderButton.frame.origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
        self.cancelOrderButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2+self.logoutButton.frame.width+15
        
                self.scanByCameraButton.alpha = 0
        //logo.alpha = 0
        self.logo.frame = CGRect(x: self.view.center.x-CGFloat(275/2), y: 275, width: 275, height: 275)
                
            }, completion: {_ in
                
                UIView.animateWithDuration(1.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {

                        self.picker.view.frame = CGRect(x: self.view.center.x-CGFloat(275/2), y: 275, width: 275, height: 275)
                        self.picker.view.hidden = false
                        self.picker.view.alpha = 1.0
                        
                        self.logo.alpha = 0.0
                    }, completion: {_ in
                        self.picker.startScanning()
                        self.picker.changeToCameraFacing(SBSCameraFacingDirectionFront)
                        self.picker.overlayController.setViewfinderHeight(Float(self.view.center.x)-Float(275/2), width: 275, landscapeHeight: 275, landscapeWidth: 275)
                })
                
                
            }
        
        )
    }
    
    override func completeTransactionResult(jsonStr: JSON)
    {
        paynowButton.enabled = true
        shoppingCartControl.clear()
        thankYouAnimation()
    }
    
    /* Delegate function called when the shopping cart control has cleared itself */
    func cartCleared()
    {
        shoppingCart.empty()
        updateCartTotal(shoppingCart)
    }
    
    var registerUserView: UpdateCardControl = UpdateCardControl()
    
    func updatecard()
    {
        registerUserView = UpdateCardControl()
        registerUserView.delegate = self
        view.addSubview(registerUserView)
        backgroundImageView.alpha = 0.50
        registerUserView.okButton.setTitle("Let's GO!", forState: .Normal)
        registerUserView.cancelButton.setTitle("Cancel", forState: .Normal)
        registerUserView.registration.phoneNumber = user.phoneNumber
        registerUserView.registration.passcode = user.passcode
        //registerUserView.jsonDataObj = jsonDataObj
    }
    
    func cancelorder()
    {
        typeBarcodeManually()
        
        return;
        
        //let product: Product = Product()
        //product.barcode = "555"
        //itemScanned(product)
        
        // Animate a cancelled transaction
        shoppingCartControl.clear()
    }
    
    func reloadFiveDollars()
    {
        reloadAccount(5.00)
    }
    
    func reloadTenDollars()
    {
        reloadAccount(10.00)
    }
    
    /* Callback function after network request completes */
    override func reloadAccountResult(jsonData: JSON)
    {
        let error = jsonData["Error"]
        
        if(error == 0)
        {
            user.balance = Double(jsonData["Balance"].double!)
            balanceAvailableButton.setTitle(formatter.stringFromNumber(user.balance), forState: .Normal)
            payNowButton()
        }
        else
        {
        if let error_message = jsonData["error_code"].int
        {
            switch(error_message)
            {
            case 3:
                registrationErrorInvalidCCV()
                break;
                
            default:
                super.processErrors(jsonData)
                break
            }
        }
        else
        {
            super.processErrors(jsonData)
        }
        }
        /*
        let error = jsonData["Error"]
        
        switch(error)
        {
        case 0:
            break
            
        default:
            break
        }
        */
    }
    
    func clearUIElements()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                self.logoutButton.alpha = 0.0
                self.balanceAvailableLabel.alpha = 0.0
                self.amountDueButton.alpha = 0.0
                self.paynowButton.alpha = 0.0
                self.amountDueLabel.alpha = 0.0
                self.updateCardButton.alpha = 0.0
                self.cancelOrderButton.alpha = 0.0
                self.scanByCameraButton.alpha = 0.0
                self.shoppingCartControl.alpha = 0.0
                self.scanItemInstructionsLabel.alpha = 0.0
                self.logo.alpha = 0.0
                self.picker.view.alpha = 0.00
                self.balanceAvailableButton.alpha = 0.0
            }, completion: {_ in
            }
        )
        
    }
    
    func thankYouAnimation()
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                
                self.logoutButton.alpha = 0.0
                self.balanceAvailableLabel.alpha = 1.0
                
                self.amountDueButton.alpha = 0.0
                self.paynowButton.alpha = 0.0
                
                self.amountDueLabel.alpha = 0.0
                self.logo.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
                self.logoutButton.frame = CGRect(x: 570, y: 30, width: 175, height: 40)
                self.updateCardButton.alpha = 0.0
                self.cancelOrderButton.alpha = 0.0
                self.scanByCameraButton.alpha = 0.0
                self.shoppingCartControl.alpha = 0.0
                self.scanItemInstructionsLabel.alpha = 1.0
                self.scanItemInstructionsLabel.text = "THANK YOU"
                self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 98)
                self.scanItemInstructionsLabel.frame = CGRect(x: 0, y: 336, width: self.view.frame.width, height: 100)
                //self.scanItemInstructionsLabel.backgroundColor = UIColor.blueColor()
                self.scanItemInstructionsLabel.textAlignment = .Center
                self.balanceAvailableLabel.text = "Your Current Balance Is:"
                self.balanceAvailableLabel.frame = CGRect(x: self.view.frame.width/2-175, y: self.scanItemInstructionsLabel.frame.origin.y+102, width: 350, height: 30)
                //self.balanceAvailableLabel.backgroundColor = UIColor.blueColor()
                self.balanceAvailableLabel.textColor = UIColor.whiteColor()
                self.balanceAvailableButton.frame =
                    CGRect(
                            x: self.view.frame.width/2-self.balanceAvailableButton.frame.width/2,
                            y: self.scanItemInstructionsLabel.frame.origin.y+145,
                            width: self.balanceAvailableButton.frame.size.width,
                            height: self.balanceAvailableButton.frame.size.height)

                
                self.doneButton = self.addButton("background_button.png", action: "logout", text: "DONE", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: self.scanItemInstructionsLabel.frame.origin.y+250, textColor: 0x80392C)
                
                self.logo.alpha = 1.0
                self.picker.view.alpha = 0.00
            }, completion: {_ in
            }
        )
    }
    
    func resetScreen()
    {
        //let distance: CGFloat = -300
        paynowButton.enabled = true
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                
                self.scanitemsbelow.alpha = 1.0
                self.scanitemstext.alpha = 1.0
                
                self.balanceAvailableButton.frame = CGRect(x: 55, y: 645, width: 211, height: 55);
                self.amountDueButton.frame = CGRect(x: 55+211+15, y: 645, width: 211, height: 55)
                self.paynowButton.frame = CGRect(x: 55+211+15+211+15, y: 645, width: 211, height: 55)
                self.balanceAvailableLabel.frame = CGRect(x: 55, y: 590, width: 211, height: 55)
                self.amountDueLabel.frame = CGRect(x: 55+211+15, y: 590, width: 211, height: 55)
                self.logo.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
                self.logoutButton.frame = CGRect(x: 570, y: 30, width: 175, height: 40)
                self.updateCardButton.frame = CGRect(x: 570, y: 30+40+15, width: 175, height: 40)
                self.cancelOrderButton.frame = CGRect(x: 570, y: 30+40+15+40+15, width: 175, height: 40)
                self.scanByCameraButton.frame = CGRect(x: 0, y: self.view.frame.height-80, width: self.view.frame.width, height: 80)
                self.shoppingCartControl.frame = CGRect(x: 51, y: 300, width: 666, height: 300)
                self.scanItemInstructionsLabel.frame = CGRect(x: 250, y: 187, width: 500, height: 70)
                self.scanItemInstructionsLabel.text = "SCAN YOUR FIRST ITEM";
                self.scanByCameraButton.alpha = 1.0
                self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 61)
                self.logo.alpha = 1.0
                self.picker.view.alpha = 0.00
            }, completion: {_ in
            }
        )
    }
    
    var animatedRegistrationProcess: AnimatedApprovalControl!
    var registrationInfo = Registration()
    
    func registrationCompleted()
    {
        let registrationInfo = registerUserView.registration
        let animatedRegistrationProgress = AnimatedApprovalControl(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), registration: registrationInfo)
        self.animatedRegistrationProcess = animatedRegistrationProgress
        view.addSubview(animatedRegistrationProgress)
        animatedRegistrationProgress.animateIn()
        
        // call registerUser
        dispatch_async(dispatch_get_main_queue(), {
            
            self.updateUser(registrationInfo)
            
        })
        
        // We need a way of being notified when this is done...
    }
    
    override func registrationConfirmed(jsonData: JSON) {
        
        let error = jsonData["Error"]
        
        switch(error)
        {
        case 0:
            dispatch_async(dispatch_get_main_queue(), {
                self.animatedRegistrationProcess.animateOut()
                //let user: User = self.user
                self.resetScreen()
                let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "Update Successfull")
                errorAlertView.cancelButton.hidden = true
                errorAlertView.centerOKButtonAnimated()
                self.view.addSubview(errorAlertView)
                //self.loginRequest(user)
            })
            
            break
            
        case 506:
            //self.bIsRegistering = true
            self.processErrors(jsonData)
            break
            
        case 610:
            //self.bIsRegistering = true
            self.processErrors(jsonData)
            //self.registrationErrorInvalidCCV()
            
            break
            
        default:
            dispatch_async(dispatch_get_main_queue(), {
                self.processErrors(jsonData)
                print("---here---")
                //self.registrationErrorInvalidCCV()
            })
            break
        }
    }
    
    var scannedBarcodeData = "";
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print(string);
        if(string != ",")
        {
        scannedBarcodeData += string
        }
        else
        {
            let product: Product = Product()
            product.barcode = scannedBarcodeData
            itemScanned(product)
            scannedBarcodeData = ""
        }

        return false
    }
    
}
