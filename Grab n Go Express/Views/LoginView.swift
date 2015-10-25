//
//  LoginView.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

class LoginView: UIController, PhoneNumberControlDelegate, PasscodeControlDelegate, RegisterUserControlDelegate {

    // Authentication Details
    var user = User()
    
    var bIsRegistering: Bool = false
    
    // Anonymous State UI
    var loginButton: UIButton = UIButton()
    var signupButton: UIButton = UIButton()
    var logoView: UIView = UIView()
    var transparentApple: UIView = UIView()
    var noAccountLabel: UILabel = UILabel()
    var arrowView: UIView = UIView()
    
    // ObtainingPhoneNumberState
    var phoneNumberInstructions = UILabel()
    var phoneNumberText = UITextView()
    var nextButton: UIButton = UIButton()
    var instructionLabel: UILabel = UILabel()
    let phoneNumberControl: PhoneNumberControl = PhoneNumberControl(instructionsText: "Enter Your Cell Phone")
    let passcodeControl: PasscodeControl = PasscodeControl(instructionsText: "Enter\nYour Passcode")
    
    // ObtainingPinNumberState
    var pinNumberInstructions = UILabel()
    var pinNumberText = PasscodeControl()
    
    var registerUserView: RegisterUserControl = RegisterUserControl()
    //var registrationInfo: Registration
    
    enum loginState{
        case Anonymous
        case ObtainingPhoneNumber
        case PhoneNumberObtained
        case ObtainingPinNumberState
        case PinNumberObtained
        case CredentialsVerified
        case CredentialPhoneNumberError
        case CredentialPinNumberError
        case VerifyingCredentials
    }
    var loginButtonOriginalX: CGFloat = 0.00
    var signupButtonOriginalX: CGFloat = 0.00
    var logoOriginalFrame: CGRect = CGRect()
    
    var loginStatus = loginState.Anonymous
    
    override func viewDidAppear(animated: Bool) {
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            print("Pad")
        }
        else
        {
            print("Phone")
            //keypadControl.frame = CGRect(x: self.frame.width/2-keypadControl.keypadControlWidth/2, y: 200, width: keypadControl.keypadControlWidth, height: keypadControl.keypadControlHeight)
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setObject(locationSerial.text, forKey: "location_serial")
        //defaults.setObject(locationUsername.text, forKey: "location_username")
        if let _ = defaults.objectForKey("location_serial")
        {
                // 10000000020
        }
        else
        {
        let configView = ConfigurationView()
        configView.view.frame = view.frame
        configView.view.backgroundColor = UIColor.whiteColor()
        self.presentViewController(configView, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //networkRequest()
        //registrationInfo = Registration()
        /*
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
        */
        
        
        // Anonymous state
        setBackgroundImage("background_green.png")
        loginButton = addButton("background_button.png", action: "login", text: "LOGIN", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 236.00, xPosW: 0, yPosW: 700, textColor: 0x80392C)
        loginButtonOriginalX = loginButton.frame.origin.x
        
        signupButton = addButton("background_button.png", action: "signup", text: "SIGNUP FOR FREE", font: "Archer-Bold", fontSize: 28.0, xPos: 0.00, yPos: 530.00, xPosW: 0, yPosW: 850, textColor: 0x80392C)
        signupButtonOriginalX = signupButton.frame.origin.x
        
        logoView = addStaticImage("logo.png", xPos: 0, yPos: 50, xPosW: 0, yPosW: 225, width: 166, height: 163, widthW: 275, heightW: 275)
        logoOriginalFrame = logoView.frame
        
        arrowView = addStaticImage("arrow.png", xPos: 0, yPos: 50, xPosW: 224, yPosW: 786, width: 166, height: 163, widthW: 80, heightW: 60)

        transparentApple = addStaticImage("green_apple.png", xPos: 0, yPos: 0, xPosW: -40, yPosW: 436, width: 50, height: 40, widthW: 200, heightW: 250)
        
        rotateView(1, theView: transparentApple)
        
        noAccountLabel = addStaticLabel("DON'T\nHAVE AN\nACCOUNT?", font: "CardenioModern-Bold", fontSize: 38, xPos: 125, yPos: 400, width: 220, height: 175, xPosW: 50, yPosW: 725, widthW: 200, heightW: 150, textColor: 0xFFAAFF)
        
        rotateView(-0.32, theView: noAccountLabel)
        
        // Obtaining Phone Number State
        nextButton = addButton("background_button.png", action: "next", text: "NEXT", font: "Archer-Bold", fontSize: 28.0, xPos: -400, yPos: 530.00, xPosW: -400, yPosW: 850, textColor: 0x80392C)
        nextButton.hidden = true
        nextButton.alpha = 0.0

        phoneNumberControl.delegate = self
        phoneNumberControl.hidden = true
        phoneNumberControl.textInput.keyboardType = .NumberPad
        view.addSubview(phoneNumberControl)
        
        passcodeControl.delegate = self
        passcodeControl.hidden = true
        view.addSubview(passcodeControl)
        
        //errorAlert("Incorrect Phone Number or Passcode", okText: "Retry", cancelText: "Cancel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func advanceState()
    {
        switch(loginStatus)
        {
        case .Anonymous:
            loginStatus = .ObtainingPhoneNumber
            animatedHideAnonymousState()
            print("Anonymous")
            break
            
        case .ObtainingPhoneNumber:
            loginStatus = .ObtainingPinNumberState
            print("ObtainingPhoneNumber")
            break
            
        case .ObtainingPinNumberState:
            loginStatus = .VerifyingCredentials
            print("ObtainingPasscode")
            break
        
        case .VerifyingCredentials:
            loginStatus = .CredentialsVerified
            break;
            
        case .CredentialsVerified:
            break
            
        case .CredentialPhoneNumberError:
            break

        case .CredentialPinNumberError:
            break
            
        default:
            break
        }
    }
    
    func signup()
    {
        loginStatus = .Anonymous
        print("Signup Button Pressed");
        bIsRegistering = true
        advanceState()
    }
    
    func login()
    {
        print("Login Button Pressed");
        advanceState()
    }
    
    override func loginResult(jsonData: JSON)
    {
        //print("loginResult called 2")
        //print(jsonData)
        let error = jsonData["Error"]
        if(error == 0)
        {
            print("Error = 0")
        user.userAuthenticated(phoneNumber, passcode: passcode)
        let selfCheckoutView: SelfCheckoutView = SelfCheckoutView()
        selfCheckoutView.view.backgroundColor = UIColor.whiteColor()
        selfCheckoutView.login(user)
        self.presentViewController(selfCheckoutView, animated: true, completion: nil)
        }
        else
        {
            resetScreen()
            processErrors(jsonData)
        }
    }
    

    
    func resetScreen()
    {
        loginStatus = .Anonymous
        user = User()
        phoneNumber = ""
        passcode = ""
        phoneNumberControl.textInput.text = ""
        passcodeControl.textInput.text = ""
        phoneNumberControl.phoneNumber = ""
        passcodeControl.passcode = ""
        
        print("Reset screen");
        print(user.phoneNumber)
        
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: .CurveEaseOut, animations: {
                self.loginButton.frame.origin.x = self.loginButtonOriginalX
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5,
            options: .CurveEaseOut, animations: {
                self.signupButton.frame.origin.x = self.signupButtonOriginalX
                self.logoView.frame = self.logoOriginalFrame
                self.logoView.alpha = 1.0
                
                self.transparentApple.alpha = 1.0
                self.noAccountLabel.alpha = 1.0
                self.arrowView.alpha = 1.0
                self.backgroundImageView.alpha = 0.0
            }, completion: {_ in
                self.setBackgroundImage("background_green.png")
                self.backgroundImageView.alpha = 0.0
                //self.phoneNumberControl.alpha = 0
                self.phoneNumberControl.hidden = true
                self.instructionLabel.hidden = true
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.backgroundImageView.alpha = 1.0
                        self.phoneNumberControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.phoneNumberControl.frame.origin.y, width: self.phoneNumberControl.frame.width, height: self.phoneNumberControl.frame.height)
                        
                        self.instructionLabel.alpha = 1.0
                    }, completion: nil);
                
                
            }
        )
    }
    
    func animatedHideAnonymousState()
    {
        phoneNumberControl.textInput.text = ""
        passcodeControl.textInput.text = ""
        phoneNumberControl.phoneNumber = ""
        passcodeControl.passcode = ""
        // Anonymous State UI
        //loginButton.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: .CurveEaseOut, animations: {
                self.loginButton.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5,
            options: .CurveEaseOut, animations: {
                self.signupButton.center.x += self.view.bounds.width
                self.logoView.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
                self.transparentApple.alpha = 0
                self.noAccountLabel.alpha = 0
                self.arrowView.alpha = 0
                self.backgroundImageView.alpha = 0
            }, completion: {_ in
                self.setBackgroundImage("background_blue.png")
                self.backgroundImageView.alpha = 0
                self.phoneNumberControl.alpha = 1.0
                self.phoneNumberControl.hidden = false
                self.instructionLabel.hidden = false
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.backgroundImageView.alpha = 1.0
                        self.phoneNumberControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.phoneNumberControl.frame.origin.y, width: self.phoneNumberControl.frame.width, height: self.phoneNumberControl.frame.height)
                        
                        self.instructionLabel.alpha = 1.0
                    }, completion: nil);
                
                
            }
        )
    }
    
    func animatedRevealAnonymousState()
    {
        // Anonymous State UI
        //loginButton.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0.4,
            options: .CurveEaseOut, animations: {
                self.loginButton.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5,
            options: .CurveEaseOut, animations: {
                self.signupButton.center.x += self.view.bounds.width
                self.logoView.frame = CGRect(x: 45, y: 30, width: 210, height: 200)
                self.transparentApple.alpha = 0
                self.noAccountLabel.alpha = 0
                self.arrowView.alpha = 0
                self.backgroundImageView.alpha = 0
            }, completion: {_ in
                self.setBackgroundImage("background_blue.png")
                self.backgroundImageView.alpha = 0
                self.phoneNumberControl.alpha = 1.0
                self.phoneNumberControl.hidden = false
                self.instructionLabel.hidden = false
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        self.backgroundImageView.alpha = 1.0
                        self.phoneNumberControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.phoneNumberControl.frame.origin.y, width: self.phoneNumberControl.frame.width, height: self.phoneNumberControl.frame.height)
                        
                        self.instructionLabel.alpha = 1.0
                    }, completion: nil);
                
                
            }
        )
    }
    
     func phoneNumberCompletion(phoneNumber: String)
     {
        
        self.phoneNumber = phoneNumber
            // Animate phoneNumberControl offscreen
      
        UIView.animateWithDuration(0.5, delay: 0.5,
            options: .CurveEaseOut, animations: {
                
                // We've got our phone number, move onto the next piece of info needed
                // Slide the phoneNumberControl to the right
                 self.phoneNumberControl.center.x += self.view.bounds.width
                
            }, completion: {_ in
                
                // Animation is complete
                self.passcodeControl.hidden = false;
                self.passcodeControl.alpha = 1.0
                
                UIView.animateWithDuration(0.5, delay: 0.0,
                    options: .CurveEaseOut, animations: {
                        
                        // Animate the next element that needs to be shown
                        self.passcodeControl.frame = CGRect(x: self.screenSize.width/2-self.phoneNumberControl.frame.width/2, y: self.passcodeControl.frame.origin.y, width: self.passcodeControl.frame.width, height: self.passcodeControl.frame.height)
                        self.advanceState()
                        
                    }, completion: nil);
                
                
            }
        )
     }
    
    func passcodeCompletion(passcode: String)
    {
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseOut, animations: {
                
                self.passcodeControl.center.x += self.view.bounds.width
                
            }, completion: nil);
        
        // What we do next will depend on whether the user is registering, or authenticating
        user.phoneNumber = phoneNumber
        user.passcode = passcode
        
        if(bIsRegistering==false)
        {
            //if(checkPin(user) == true)
            //{
            
                //print("checkPin returned true");
                // Let's move on to our SelfCheckoutView
                loginRequest(user)
            //}
            //else
            //{
            //
            //    print("checkPin returned false")
            //    user.userLoggedOff()
            //}
        }
        else
        {
            // Let's start our registration process
            registerUserWizard()
        }
    }
    
    override func errorOK() {
        super.errorOK()
    }
    
    override func errorCancel() {
        super.errorCancel()
        resetScreen()
    }
    
    var registrationInfo = Registration()
    
    func registerUserWizard()
    {
        registerUserView = RegisterUserControl()
        registerUserView.delegate = self
        bIsRegistering = false
        view.addSubview(registerUserView)
        backgroundImageView.alpha = 0.50
        registerUserView.okButton.setTitle("Let's GO!", forState: .Normal)
        registerUserView.cancelButton.setTitle("Cancel", forState: .Normal)
        registerUserView.registration.phoneNumber = user.phoneNumber
        registerUserView.registration.passcode = user.passcode
        print(user)
    }
    
    var animatedRegistrationProcess: AnimatedApprovalControl!
    
    func registrationCompleted()
    {
        registrationInfo = registerUserView.registration
        let animatedRegistrationProgress = AnimatedApprovalControl(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height), registration: registrationInfo)
        self.animatedRegistrationProcess = animatedRegistrationProgress
        view.addSubview(animatedRegistrationProgress)
        animatedRegistrationProgress.animateIn()

        print("registrationCompeleted called")
        
        // call registerUser
        dispatch_async(dispatch_get_main_queue(), {
            
        self.registerUser(self.registrationInfo)
            
        })
        
        // We need a way of being notified when this is done...
    }
    
    override func registerUserCompleted(jsonStr: String) {
    
    }
    
    override func registrationConfirmed(jsonData: JSON) {
        
        print("registrationConfirmed")
        let error = jsonData["Error"]
        print(jsonData)
        switch(error)
        {
        case 0:
            dispatch_async(dispatch_get_main_queue(), {
                self.animatedRegistrationProcess.animateOut()
                let user: User = self.user
                self.resetScreen()
                let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "Registration Successfull")
                errorAlertView.cancelButton.hidden = true
                errorAlertView.centerOKButtonAnimated()
                self.view.addSubview(errorAlertView)
                //self.loginRequest(user)
            })
            
            break
            
        case 610:
            dispatch_async(dispatch_get_main_queue(), {
                self.registrationErrorInvalidCCV()
                })
            break
            
        default:
            dispatch_async(dispatch_get_main_queue(), {
                self.processErrors(jsonData)
                //self.registrationErrorInvalidCCV()
            })
            break
        }
    }
    
    override func processErrors(jsonData: JSON) {

        animatedRegistrationProcess.animateOut()
        super.processErrors(jsonData)
        
        /*
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "The CCV code doesn't match, please re-enter")
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        errorAlertView.okButton.setTitle("Re-Enter", forState: .Normal)
        errorAlertView.cancelButton.setTitle("Cancel", forState: .Normal)
        errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        errorAlertView.okButton.addTarget(self, action: "retryCCV", forControlEvents: UIControlEvents.TouchDown)
        myAlert = errorAlertView
        */
    }
    
    func registrationError(jsonData: NSString) {
        
    }
    
    var myAlert: ErrorAlertControl = ErrorAlertControl()
    
    override func registrationErrorInvalidCard(){
        animatedRegistrationProcess.animateOut()
        
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "There was a problem reading your credit card.  Please swipe it again")
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        errorAlertView.okButton.setTitle("Swipe Credit Card", forState: .Normal)
        errorAlertView.cancelButton.setTitle("Cancel", forState: .Normal)
        errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        errorAlertView.okButton.addTarget(self, action: "retryCreditCard:", forControlEvents: UIControlEvents.TouchDown)
        myAlert = errorAlertView
    }
    
    func retryCreditCard(sender: UIButton)
    {
        print("Retrying credit card action")
        myAlert.ok()
        
        registerUserWizard()
        registerUserView.currentState = RegisterUserControl.registrationState.justStarted
        
        registerUserView.label.text = registerUserView.getNextStateText()
    }
    
    override func registrationErrorInvalidZipcode(){

        animatedRegistrationProcess.animateOut()
        
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "The zip code doesn't match, please re-enter")
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        errorAlertView.okButton.setTitle("Re-Enter", forState: .Normal)
        errorAlertView.cancelButton.setTitle("Cancel", forState: .Normal)
        errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        errorAlertView.okButton.addTarget(self, action: "retryZipcode", forControlEvents: UIControlEvents.TouchDown)
        myAlert = errorAlertView
    }
    
    func retryZipcode()
    {
        print("Retrying zip action")
        myAlert.ok()
        //registerUserView = RegisterUserControl()
        registerUserView.currentState = RegisterUserControl.registrationState.creditCardSwiped
        registerUserWizard()
        registerUserView.label.text = registerUserView.getNextStateText()
    }
    
    override func registrationErrorInvalidCCV(){
        animatedRegistrationProcess.animateOut()
        
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "The CCV code doesn't match, please re-enter")
        errorAlertView.delegate = self
        view.addSubview(errorAlertView)
        backgroundImageView.alpha = 0.50
        errorAlertView.okButton.setTitle("Re-Enter", forState: .Normal)
        errorAlertView.cancelButton.setTitle("Cancel", forState: .Normal)
        errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        errorAlertView.okButton.addTarget(self, action: "retryCCV", forControlEvents: UIControlEvents.TouchDown)
        myAlert = errorAlertView
    }
    
    func retryCCV()
    {
        undoRegisterUser(registerUserView.registration)
        print("Retrying CCV action")
        print(registerUserView.registration)
        let tempRegistration = registerUserView.registration
        registerUserWizard()
        registerUserView.registration = tempRegistration
        registerUserView.currentState = RegisterUserControl.registrationState.zipCodeEntered
        // creditCardSwiped
        //registerUserView.currentState = RegisterUserControl.registrationState.creditCardSwiped
        registerUserView.bResizeFrame = true
        registerUserView.label.text = registerUserView.getNextStateText()
        myAlert.ok()
        return;
    }
    
    override func undoRegisterUserConfirmed(jsonData: JSON)
    {
        
    }
    
    override func registrationErrorExpiredCard(){
        animatedRegistrationProcess.animateOut()
        errorAlert("The credit card you swiped is expired", okText: "Retry", cancelText: "Cancel")
    }
    
    override func registrationErrorUnsupportedCard(){
        animatedRegistrationProcess.animateOut()
        errorAlert("We don't support this card type.  Please try a different card", okText: "Retry", cancelText: "Cancel")
    }
    
    override func registrationErrorAccountAlreadyExists(){
        animatedRegistrationProcess.animateOut()
        errorAlert("This account already exists", okText: "Text Me My Passcode", cancelText: "Cancel")
    }
    
    override func timeout() {

        //if(bIsRegistering==true)
        //{
            animatedRegistrationProcess.animateOut()
        //}
        
        resetScreen()
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: "Unable to connect to the Internet.  Please call your service provider.  I am unable to continue")
        errorAlertView.delegate = self
        self.view.addSubview(errorAlertView)
        errorAlertView.okButton.setTitle("Retry", forState: .Normal)
        errorAlertView.centerCancelButtonAnimated()
        errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        errorAlertView.okButton.addTarget(self, action: "retryInternetDown", forControlEvents: UIControlEvents.TouchDown)
        self.myAlert = errorAlertView
    }
    
    func retryInternetDown(){
        //registrationCompleted()
    }
    
    func cancelErrorAlert(){
        myAlert.ok()
    }
}


