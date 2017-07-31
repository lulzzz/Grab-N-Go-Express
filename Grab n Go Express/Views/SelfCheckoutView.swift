//
//  SelfCheckoutView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

@objc protocol SelfCheckoutViewDelegate{
    @objc func viewDismissed()
}


class SelfCheckoutView: UIController, ShoppingCartControlDelegate, ApiResultsDelegate, PaymentOptionsDelegate, NoScanItemDelegate, RegisterUserControlDelegate, UITextFieldDelegate, DollarBillAcceptorDelegate {
    
    var delegate: SelfCheckoutViewDelegate!
    
    /* Our Model Classes */
    var user: User = User()
    var location: Location = Location()
    var transaction: Transaction = Transaction()
    var shoppingCart: ShoppingCart = ShoppingCart()
    
    let formatter = NumberFormatter()
    
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
    
    var lastItemCount = 0;
    
    var payNow = true;
    
    var myInputView : UIView!
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        
        
        /*
        Timeout(5.0) { self.itemTypedIn("555") }
        
        Timeout(15.0) { self.itemTypedIn("555") }
        
        Timeout(30.0) { self.itemTypedIn("555") }
        
        Timeout(45.0) { self.payNowButton() }
        
        Timeout(60.0) { self.logout() }
        */
 // A new login
        // Let's check it out.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        resetJsonObj()
        resetScreen();
    }
    
    let menuButtonColor: UIColor = UIColor(red: 215/255, green: 221/255, blue: 59/255, alpha: 1.0)
    let menuButtonTextColor: UIColor = UIColor(red: 104/255, green: 112/255, blue: 21/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad");
        
        
        setBackgroundImage("background_green.png")
        formatter.numberStyle = NumberFormatter.Style.currency
        // Do any additional setup after loading the view.
        
        //addButton("background_button.png", action: "login", text: "LOGIN", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 210, textColor: 0x80392C)
        
        balanceAvailableButton.frame = CGRect(x: 55, y: 645, width: 211, height: 55)
        balanceAvailableButton.backgroundColor = UIColor.white
        balanceAvailableButton.setTitleColor(UIColor.black, for: UIControlState())
        balanceAvailableButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        view.addSubview(balanceAvailableButton)
        
        amountDueButton.frame = CGRect(x: 55+211+15, y: 645, width: 211, height: 55)
        amountDueButton.backgroundColor = UIColor.white
        amountDueButton.setTitleColor(UIColor.black, for: UIControlState())
        amountDueButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        amountDueButton.setTitle(formatter.string(from: 0), for: UIControlState())
        view.addSubview(amountDueButton)
        
        paynowButton.frame = CGRect(x: 55+211+15+211+15, y: 645, width: 211, height: 55)
        paynowButton.backgroundColor = UIColor.red
        paynowButton.setTitleColor(UIColor.white, for: UIControlState())
        paynowButton.titleLabel?.font = UIFont(name: "Archer-Bold", size: 36)
        paynowButton.setTitle("PAY NOW", for: UIControlState())
        paynowButton.addTarget(self, action: #selector(SelfCheckoutView.payNowButton), for: UIControlEvents.touchDown)
        view.addSubview(paynowButton)
        
        balanceAvailableLabel.frame = CGRect(x: 55, y: 590, width: 211, height: 55)
        balanceAvailableLabel.text = "Balance"
        balanceAvailableLabel.font = UIFont(name: "Arial", size: 28)
        balanceAvailableLabel.textAlignment = .center
        view.addSubview(balanceAvailableLabel)
        
        amountDueLabel.frame = CGRect(x: 55+211+15, y: 590, width: 211, height: 55)
        amountDueLabel.text = "Amount Due"
        amountDueLabel.font = UIFont(name: "Arial", size: 28)
        //amountDueLabel.backgroundColor = UIColor.whiteColor()
        amountDueLabel.textAlignment = .center
        view.addSubview(amountDueLabel)
        
        logo = addStaticImage("logo.png", xPos: 0, yPos: 50, xPosW: 0, yPosW: 225, width: 166, height: 163, widthW: 275, heightW: 275)
        logo.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
        
        self.scanitemsbelow =  addStaticImage("scanitem.png",          xPos: 460, yPos: 720, xPosW: 460, yPosW: 720, width: 166, height: 163, widthW: 247, heightW: 243)
        self.scanitemstext = addStaticImage("scanselections.png",    xPos: 460, yPos: 720, xPosW: 160, yPosW: 715, width: 146, height: 143, widthW: 279, heightW: 256)
        
        
        scanItemInstructionsLabel = addStaticLabel("SCAN YOUR FIRST ITEM", font: "CardenioModern-Bold", fontSize: 61, xPos: 125, yPos: 400, width: 420, height: 202, xPosW: 250, yPosW: 187, widthW: 500, heightW: 70, textColor: 0xFFAAFF)
        scanItemInstructionsLabel.textAlignment = .left
        
        
        logoutButton.frame = CGRect(x: 570, y: 30, width: 175, height: 40)
        logoutButton.setTitle("logout", for: UIControlState())
        logoutButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        logoutButton.backgroundColor = menuButtonColor
        logoutButton.setTitleColor(menuButtonTextColor, for: UIControlState())
        logoutButton.addTarget(self, action: #selector(SelfCheckoutView.logoutAction), for: .touchDown)
        view.addSubview(logoutButton)
        
        updateCardButton.frame = CGRect(x: 570, y: 30+40+15, width: 175, height: 40)
        updateCardButton.setTitle("update card", for: UIControlState())
        updateCardButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        updateCardButton.backgroundColor = menuButtonColor
        updateCardButton.setTitleColor(menuButtonTextColor, for: UIControlState())
        updateCardButton.addTarget(self, action: #selector(SelfCheckoutView.updatecard), for: .touchDown)
        view.addSubview(updateCardButton)
        
        cancelOrderButton.frame = CGRect(x: 570, y: 30+40+15+40+15, width: 175, height: 40)
        cancelOrderButton.setTitle("item lookup", for: UIControlState())
        cancelOrderButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        cancelOrderButton.backgroundColor = menuButtonColor
        cancelOrderButton.setTitleColor(menuButtonTextColor, for: UIControlState())
        cancelOrderButton.addTarget(self, action: #selector(SelfCheckoutView.cancelorder), for: .touchDown)
        view.addSubview(cancelOrderButton)
        
        scanByCameraButton = UIButton(frame: CGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50))
        scanByCameraButton.setTitle("Scan By Using the iPad's Camera", for: UIControlState())
        scanByCameraButton.titleLabel?.font = UIFont(name: "Arial", size: 28)
        scanByCameraButton.backgroundColor = menuButtonColor
        scanByCameraButton.setTitleColor(menuButtonTextColor, for: UIControlState())
        scanByCameraButton.addTarget(self, action: #selector(SelfCheckoutView.scanbycamera), for: .touchDown)
        view.addSubview(scanByCameraButton)
        
        shoppingCartControl.frame = CGRect(x: 51, y: 300, width: 666, height: 300)
        //shoppingCartControl.backgroundColor = UIColor.whiteColor()
        shoppingCartControl.shoppingCartDelegate = self
        view.addSubview(shoppingCartControl)
        
        shoppingCartDelegate = self
        
        let textInputRect: CGRect = CGRect(x: -339, y: -75, width: 339, height: 75)
        textInput.frame = textInputRect
        textInput.textAlignment = .center
        textInput.allowsEditingTextAttributes = false
        textInput.backgroundColor = UIColor.red
        textInput.borderStyle = UITextBorderStyle.line
        textInput.becomeFirstResponder()
        //textInput.autocorrectionType = UITextAutocorrectionType.No
        //textInput.keyboardType = .NumberPad
        textInput.delegate = self
        textInput.inputView = myInputView
        
        // external_barcode_scanner
        let external_barcode_scanner = UserDefaults.standard.bool(forKey: "external_barcode_scanner")
        
        if(external_barcode_scanner)
        {
            view.addSubview(textInput)
            hideTheAssistantBar(self.view);
        }
        
        
        
        let camera_by_default = UserDefaults.standard.bool(forKey: "camera_default")
        
        if(camera_by_default)
        {
            scanbycamera()
        }
    }
    
    func hideTheAssistantBar(_ view:UIView) {
        
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
        
        // swift 3 change
        //for subview : AnyObject in subviews {
        //    if subview.isKind(of: UIView().self) {
        //
        //        hideTheAssistantBar(subview as! UIView)
        //    }
        //}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        balanceAvailableButton.setTitle(formatter.string(from: NSNumber(value: user.balance)), for: UIControlState())
        setBaseParameters(user)
        textInput.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("Received memory warning");
    }
    
    func login(_ user: User)
    {
        self.user = user
        lastItemCount = 0
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
    func itemAdded(_ product: Product)
    {
        shoppingCart.addProduct(product)
        lastItemCount = lastItemCount + 1
    }
    
    /* This is a delegate called by the shopping cart control after an item is removed */
    func itemRemoved(_ product: Product)
    {
        shoppingCart.removeProduct(product)
        lastItemCount = lastItemCount - 1
    }
    
    func updateCartTotal(_ shoppingCart: ShoppingCart)
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amountDue = formatter.string(from: NSNumber(value: self.shoppingCart.totalCartValue()))
        amountDueButton.setTitle(amountDue, for: UIControlState())
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
        transaction.date_time = Date()
        
        print(totalAmountDue)
        print(user.balance)
        if(totalAmountDue <= user.balance)
        {
            transaction.bSuccessfullTransaction = true
            // Submit the transaction to the server, wait for the response
            let accountBalance = user.balance - totalAmountDue
            let accountBalanceString = formatter.string(from: NSNumber(value: accountBalance))
            balanceAvailableButton.setTitle(accountBalanceString, for: UIControlState())
            user.balance = accountBalance
            paynowButton.isEnabled = false
            completeTransaction(transaction)
        }
        else
        {
            // Do a recharge
            errorAlertView = ErrorAlertControl(errorText: "You do not have enough money to complete this transaction")
            errorAlertView.cancelButton.isHidden = false
            //backgroundImageView.alpha = 0.50
            errorAlertView.okButton.setTitle("Reload", for: UIControlState())
            //errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
            errorAlertView.okButton.addTarget(self, action: #selector(SelfCheckoutView.rechargeAccount), for: UIControlEvents.touchDown)
            self.view.addSubview(errorAlertView)
        }
    }
    
    var errorAlertView: ErrorAlertControl!
    
    func itemTypedIn(_ barcode: String)
    {
        let product: Product = Product()
        product.barcode = barcode
        print("itemTypedIn called");
        print(user.phoneNumber)
        print(user.passcode);
        
        addParameter("phone_num", value: user.phoneNumber as AnyObject);
        addParameter("pin_num", value: user.passcode as AnyObject)
        itemScanned(product)
    }
    
    func typeBarcodeManually()
    {
        let view = NoScanItemView()
        
        view.setBaseParameters(user)
        
        view.delegate = self
        view.phoneNumber = phoneNumber
        view.passcode = passcode
        
        self.present(view, animated: true, completion: nil)
    }
    
    func rechargeAccount()
    {
        //clearUIElements()
        errorAlertView.removeFromSuperview()
        let view = PaymentOptionsView(cartTotal: shoppingCart.totalCartValue())
        view.delegate = self
        self.present(view, animated: true, completion: nil)
    }
    
    /* reloadAccount is a delegate of PaymentOptionsView */
    override func reloadAccount(_ amount: Double)
    {
        addParameter("phone_num", value: user.phoneNumber as AnyObject);
        addParameter("pin_num", value: user.passcode as AnyObject)
        
        super.reloadAccount(amount)
        // Reloading our account!
    }
    
    func logout()
    {
        
        paynowButton.isEnabled = true
        shoppingCartControl.clear()
        
        shoppingCart = ShoppingCart();
        transaction.shoppingCart = shoppingCart
        transaction.user = user
        transaction.bSuccessfullTransaction = false
        transaction.date_time = Date()
        
        transaction.bSuccessfullTransaction = true
        
        let accountBalance = user.balance
        let accountBalanceString = formatter.string(from: NSNumber(value: accountBalance))
        balanceAvailableButton.setTitle(accountBalanceString, for: UIControlState())
        user.balance = accountBalance
        paynowButton.isEnabled = false
        
        //completeTransaction(transaction)
        
        self.scanItemInstructionsLabel.isHidden = false;
        self.scanItemInstructionsLabel.text = String(lastItemCount)
        self.view.bringSubview(toFront: scanItemInstructionsLabel)
        
        doneButton.alpha = 0.0;
        balanceAvailableLabel.alpha = 0.0;
        balanceAvailableButton.alpha = 0.0;
        
        UIView.animate(withDuration: 2.5, delay: 0.0,
                       options: .curveEaseOut, animations: {
                        self.backgroundImageView.alpha = 0.0
                        self.scanItemInstructionsLabel.textColor = UIColor.black
                        self.scanItemInstructionsLabel.frame = CGRect(x: 0, y: 0, width: self.screenSize.width, height: self.screenSize.height)
                        
                        self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 1150)
        }, completion: {_ in
            
            
            
            self.lastItemCount = 0
            
            Timeout(3.0) {
                self.delegate.viewDismissed();
                self.dismiss(animated: true, completion: nil)
                self.resetScreen();
            }

            
        });
        
        
    }
    
    
    /*  This actually adds the product into the shoppingCartControl
     
     */
    func barcodeScanned(_ product: Product)
    {
        print("barcode Scanned called");
        shoppingCartControl.addProduct(product)
    }
    
    func itemLookup(_ itemList: ItemLookup)
    {
        
    }
    
    
    /* This is the delegate function for the camera-based barcode scanned */
    override func barcodePicker(_ picker: SBSBarcodePicker!, didScan session: SBSScanSession!) {
        
        let barcodes_scanned: Array = session.newlyRecognizedCodes
        let barcode: SBSCode = barcodes_scanned[0] as! SBSCode;
        let product: Product = Product()
        product.barcode = barcode.data
        itemScanned(product)
    }
    
    /* This is the delegate function for the physically attached Linea-Pro Barcode Reader */
    func barcodeData(_ barcode: String!, type: Int32)
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
        /*
         let distance: CGFloat = 300
         
         UIView.animate(withDuration: 0.5, delay: 0.0,
         options: .curveEaseOut, animations: {
         
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
         self.scanItemInstructionsLabel.textAlignment = .center
         self.scanItemInstructionsLabel.font = UIFont(name: "CardenioModern-Bold", size: 50)
         self.shoppingCartControl.frame.origin.y += distance
         
         origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
         self.logoutButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2
         self.updateCardButton.frame.origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
         self.updateCardButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2-self.logoutButton.frame.width-15
         self.cancelOrderButton.frame.origin.y = self.scanItemInstructionsLabel.frame.origin.y + 140
         self.cancelOrderButton.frame.origin.x = self.view.frame.width/2-self.logoutButton.frame.width/2+self.logoutButton.frame.width+15
         
         self.scanByCameraButton.alpha = 0
         //logo.alpha = 0
         self.logo.frame = CGRect(x: self.view.center.x-CGFloat(275/2), y: 275, width: 275, height: 275)
         
         }, completion: {_ in
         
         UIView.animate(withDuration: 1.5, delay: 0.0,
         options: .curveEaseOut, animations: {
         
         self.picker.view.frame = CGRect(x: self.view.center.x-CGFloat(275/2), y: 275, width: 275, height: 275)
         self.picker.view.isHidden = false
         self.picker.view.alpha = 1.0
         
         self.logo.alpha = 0.0
         }, completion: {_ in
         self.picker.startScanning()
         self.picker.change(toCameraFacing: SBSCameraFacingDirectionFront)
         self.picker.overlayController.setViewfinderHeight(Float(self.view.center.x)-Float(275/2), width: 275, landscapeHeight: 275, landscapeWidth: 275)
         })
         
         
         }
         
         )
         */
    }
    
    override func completeTransactionResult(_ jsonStr: JSON)
    {
        paynowButton.isEnabled = true
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
        registerUserView.okButton.setTitle("Let's GO!", for: UIControlState())
        registerUserView.cancelButton.setTitle("Cancel", for: UIControlState())
        registerUserView.registration.phoneNumber = user.phoneNumber
        registerUserView.registration.passcode = user.passcode
        //registerUserView.jsonDataObj = jsonDataObj
    }
    
    func cancelorder()
    {
        typeBarcodeManually()
        
        //reloadAccount(1.00);
        //print("cancel order");
        
        
        //let product: Product = Product()
        //product.barcode = "555"
        //itemScanned(product)
        
        // Animate a cancelled transaction
        //shoppingCartControl.clear()
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
    override func reloadAccountResult(_ jsonData: JSON)
    {
        let error = jsonData["Error"]
        
        if(error == 0)
        {
            user.balance = Double(jsonData["Balance"].double!)
            balanceAvailableButton.setTitle(formatter.string(from: NSNumber(value: user.balance)), for: UIControlState())
            if(payNow == true)
            {
                payNowButton()
            }
            payNow = true;
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
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       options: .curveEaseOut, animations: {
                        
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
                        self.scanItemInstructionsLabel.textAlignment = .center
                        self.balanceAvailableLabel.text = "Your Current Balance Is:"
                        self.balanceAvailableLabel.frame = CGRect(x: self.view.frame.width/2-175, y: self.scanItemInstructionsLabel.frame.origin.y+102, width: 350, height: 30)
                        //self.balanceAvailableLabel.backgroundColor = UIColor.blueColor()
                        self.balanceAvailableLabel.textColor = UIColor.white
                        self.balanceAvailableButton.frame =
                            CGRect(
                                x: self.view.frame.width/2-self.balanceAvailableButton.frame.width/2,
                                y: self.scanItemInstructionsLabel.frame.origin.y+145,
                                width: self.balanceAvailableButton.frame.size.width,
                                height: self.balanceAvailableButton.frame.size.height)
                        
                        
                        self.doneButton = self.addButton("background_button.png", action: #selector(SelfCheckoutView.logoutAction), text: "DONE", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: self.scanItemInstructionsLabel.frame.origin.y+250, textColor: 0x80392C)
                        
                        self.logo.alpha = 1.0
                        self.picker.view.alpha = 0.00
        }, completion: {_ in
            
            
            //self.logout();
            
            // Set auto timeout here...
        }
        )
    }
    
    func logoutAction()
    {
        lastItemCount = 0;
        print("Last Item Count: ", lastItemCount);
        logout();
    }
    
    override func resetScreen()
    {
        logoutButton.alpha = 1.0
        balanceAvailableLabel.alpha = 1.0
        amountDueButton.alpha = 1.0
        paynowButton.alpha = 1.0
        amountDueLabel.alpha = 1.0
        updateCardButton.alpha = 1.0
        cancelOrderButton.alpha = 1.0
        scanByCameraButton.alpha = 1.0
        shoppingCartControl.alpha = 1.0
        scanItemInstructionsLabel.alpha = 1.0
        logo.alpha = 1.0
        picker.view.alpha = 1.00
        balanceAvailableButton.alpha = 1.0
        backgroundImageView.alpha = 1.0
        
        doneButton.frame = CGRect();
        doneButton.alpha = 0;
        doneButton.removeFromSuperview();
        
        textInput.inputView = myInputView

        paynowButton.isEnabled = true
        
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       options: .curveEaseOut, animations: {
                        
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
        let animatedRegistrationProgress = AnimatedApprovalControl(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), registration: registrationInfo!)
        self.animatedRegistrationProcess = animatedRegistrationProgress
        view.addSubview(animatedRegistrationProgress)
        animatedRegistrationProgress.animateIn()
        
        // call registerUser
        DispatchQueue.main.async(execute: {
            
            self.updateUser(registrationInfo!)
            
        })
        
        // We need a way of being notified when this is done...
    }
    
    override func registrationConfirmed(_ jsonData: JSON) {
        
        let error = jsonData["Error"]
        
        switch(error)
        {
        case 0:
            DispatchQueue.main.async(execute: {
                self.animatedRegistrationProcess.animateOut()
                //let user: User = self.user
                self.resetScreen()
                let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "Update Successfull")
                errorAlertView.cancelButton.isHidden = true
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
            DispatchQueue.main.async(execute: {
                self.processErrors(jsonData)
                print("---here---")
                //self.registrationErrorInvalidCCV()
            })
            break
        }
    }
    
    var scannedBarcodeData = "";
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
    
    func billAccepted(_ value: Double) {
        user.balance = user.balance + value;
        balanceAvailableButton.setTitle(formatter.string(from: NSNumber(value: user.balance)), for: UIControlState())
        //payNow = false;
        //reloadAccount(value);
        addCashCreditToBalance(value);
    }
    
    override func addCashCreditToBalanceResult(_ jsonStr: JSON)
    {
        
    }
    
    func log(_ msg: String) {
        networkLoadingView.text = msg;
        displayLoading()
    }
    
    func cableConnected()
    {
        networkLoadingView.text = "Cable Connected";
        displayLoading()
    }
    
    func cableDisconnected()
    {
        networkLoadingView.text = "Cable Disconnected";
        displayLoading()
    }
    
    func logs(_ msg: String) {
        
    }
    
    
}
