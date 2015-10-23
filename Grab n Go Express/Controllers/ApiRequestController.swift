//
//  ApiRequestController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit

/*
    This is where we implement the WebService

*/

class ApiRequestController: JsonRequestController {

    // URL of our resource
    var _url: String!
    var _endpoint: String!
    var _parameter: String!
    var _id: Int!
    
    var bUrlIsSet: Bool = false
    var bEndpointIsSet: Bool = false
    var bParameterIsSet: Bool = false
    var bIDIsSet: Bool = false
    
    // A phone number and passcode is required for every API request
    // Since this class is an implementation of the REST API, we'll store
    // this if checkPin returns true
    var phoneNumber: String = ""
    var passcode: String = ""
    
    
    // To do: implement the ability to add headers,
    // such as Authentication: Basic XXXX, etc.
    
    /* Errors */
    /*
    Errors
    
    401     No action identifier in json
    402     No phone number
    403     No pin num
    404     Phone number is too short
    405     Phone number is too long
    500     Unknown exception or unable to connect to database
    501     Authenticate:   no such user
    502     Authenticate:   passcode is incorrect
    506     Authenticate:   user already registered
    600     Token Charge:   Invalid phone number
    601     Token Charge:   Invalid pin number
    610     Token Charge:   No token hex provided
    611     Token Charge:   Unable to charge token
    602     Token Registration:   No credit card provided
    603     Token Registration:   No expiration date
    604     Token Registration:   Invalid zip code
    605     Token Registration:   Invalid CCV Code
    610     Token Registration:   Unable to obtain token
    612     Token Registration:   Problem obtaining token
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorDescriptions[401] = "No Action Identifier in Json";
        errorDescriptions[402] = "No Phone Number Provided in Json";
        errorDescriptions[403] = "No Passcode Provided in Json";
        errorDescriptions[404] = "Phone Number in Json is too short";
        errorDescriptions[405] = "Phone Number in Json is too long";
        errorDescriptions[500] = "Unknown Error - General Exception";
        errorDescriptions[501] = "This Phone Number is not Registered";
        errorDescriptions[502] = "The Passcode Provided is Incorrect";
        errorDescriptions[506] = "This Phone Number is Already Registered";
        errorDescriptions[600] = "Invalid Phone Number Provided";
        errorDescriptions[601] = "Invalid Pin Number Provided";
        errorDescriptions[602] = "No credit card provided";
        errorDescriptions[604] = "Invalid Zip Code";
        errorDescriptions[605] = "Invalid CCV Code";
        errorDescriptions[401] = "No Action Identifier in Json";
        errorDescriptions[610] = "No Token Hex Provided in Json";
        errorDescriptions[611] = "Unable to Charge Credit Card";
        
        
        // Do any additional setup after loading the view.
    }

    func processErrors(jsonData: JSON)
    {
        print(jsonData)
        let error: NSNumber = jsonData["Error"].number!
        let errorInt: Int = error.integerValue
        let errorAlertView: ErrorAlertControl = ErrorAlertControl(errorText: errorDescriptions[errorInt]!)
        view.addSubview(errorAlertView)
        errorAlertView.centerOKButtonAnimated()
        //backgroundImageView.alpha = 0.50
        //errorAlertView.okButton.setTitle("Re-Enter", forState: .Normal)
        //errorAlertView.cancelButton.setTitle("Cancel", forState: .Normal)
        //errorAlertView.okButton.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
    
        //errorAlertView.okButton.addTarget(self, action: "retryCCV", forControlEvents: UIControlEvents.TouchDown)
        
        /*
        
        cell.textLabel?.text = "\(key)"
        cell.detailTextLabel?.text = value.description
        animatedRegistrationProcess.animateOut()
        
        myAlert = errorAlertView
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Setter functions
    func setResourceURL(url: String)
    {
        _url = url;
        bUrlIsSet = true
    }

    func setResourceEndpoint(endpoint: String)
    {
        _endpoint = endpoint
        bEndpointIsSet = true
    }
    
    func setResourceParameter(parameter: String)
    {
        _parameter = parameter
        bParameterIsSet = true
    }
    
    func setResourceID(id: Int)
    {
        _id = id
        bIDIsSet = true
    }
    
    // Getter functions
    
    func getResourceUrl() -> String
    {
        return _url
    }
    
    func getResourceEndpoint() -> String
    {
        return _endpoint
    }
    
    func getResourceParameter() -> String
    {
        return _parameter
    }
    
    func getResourceID() -> Int
    {
        return _id
    }
    
    /* I really like conventions.  So, here's how my conventions
    // work for my API's.
    
    A camelCased function will correspond to camel_cased for the api "action item"
    
    The first word in the function indicates what type of HTTP Verb the request will make:
    GET, PUT, POST, PATCH and DELETE
    
    The second word in the function name is the resource endpoint.
    
    So, for example: getProductDatabase() would be using the HTTP GET verb, and the url would
    look like this: /product
    
    Finally, the parameter would be represented like /product/id
    
    The endpoint should only be set once, and represents where the resource is located.
    So, for example, if we're accessing /product/15, and we're using a versioned API, 1.5, 
    http://www.mydomain.com/api/1.5/product/15 might be what the final URL looks like.
    You would called "setResourceEndpoint() with "setResourceEndpoint("api/1.5")
    
    So, to setup your endpoint fully, you would need to call
    
    setResourceUrl("www.mydomain.com")
    setResourceEndpoint("api/1.5")
    
    The functions that map to the actual API will call setResourceParameter("product")
    and "setResourceID(15)" accordingly.
    
    Finally, this class is intended to return JSON Encoded responses only.
    A subclass is expected to turn these json responses and load them 
    into Swift datatypes.
    
    post_register
    post_login
    get_item
    post_transaction
    
    /register
    /login
    /product
    /transaction
    /replenish
    /user
    
    */
    
    func getProductDatabase(customerID: String) -> String
    {
        // Here we're checking to make sure that expected parameters
        // were set.  If not, we're letting them know what was forgotton
        if(standardErrors().isEmpty == false)
        {
            return standardErrors()
        }
        
        if(errorExit(customerID) == true)
        {
            //return error("Invalid customer_id")
        }
        
        return ""
    }
    
    func putRegisterToken()
    {
        
    }
    
    func getPickingSlip()
    {
        
    }
    
    func getProducts()
    {
        
    }
    
    func addItem()
    {
        
    }
    
    func getUserTransactions()
    {
        
    }
    
    func getTransactionDetails()
    {
        
    }
    
    func replenishAccount()
    {
        
    }
    
    func userSearch()
    {
        
    }
    
    func itemLookup()
    {
        
    }
    
    func getNonBarcode()
    {
        
    }
    
    func createAccount()
    {
        
    }
    
    func getMarketCardUser()
    {
        
    }
    
    func getUserBalance()
    {
        
    }
    
    func checkPin(user: User) -> Bool
    {
        // contact the network and see if the pin number is correct
        let bValidCredentials: Bool = super.checkPin(user.phoneNumber, passcode: user.passcode)
        return bValidCredentials
    }

    func loginRequest(user: User) -> Bool
    {
        print(user)
        addParameter("phone_num", value: user.phoneNumber)
        addParameter("pin_num", value: user.passcode)
        addParameter("action", value: "login")
        networkRequest(loginResult)
        return false
    }
    
    func loginResult(jsonData: JSON)
    {
        print("loginResult called")
    }
    
    func registerUser(registration: Registration)
    {
        resetJsonObj()
        // For now, set a timer to simulate contacting the network
        // to complete the registration process
        addParameter("first_name", value: registration.first_name)
        addParameter("last_name", value: registration.last_name)
        addParameter("cc_num", value: registration.cc_info)
        addParameter("exp_date", value: registration.exp_date)
        addParameter("ccv", value: registration.ccv)
        addParameter("pin_num", value: registration.passcode)
        addParameter("phone_num", value: registration.phoneNumber)
        addParameter("zipcode", value: registration.zipcode)
        addParameter("action", value: "register")
        
        print(registration)
        networkRequest(registrationConfirmed)
        
        
    }
    
    func registerUserCompleted(jsonStr: String)
    {
        //var timer = NSTimer()
        //timer = NSTimer.scheduledTimerWithTimeInterval(5, target:self, selector: Selector("registrationErrorInvalidCCV"), userInfo: nil, repeats: false)
    }
    
    func finishIncompleteRegistration(registration: Registration)
    {
        resetJsonObj()
        addParameter("action", value: "finish_incomplete_registration")
        // For now, set a timer to simulate contacting the network
        // to complete the registration process
        addParameter("first_name", value: registration.first_name)
        addParameter("last_name", value: registration.last_name)
        addParameter("cc_num", value: registration.cc_info)
        addParameter("exp_date", value: registration.exp_date)
        addParameter("ccv", value: registration.ccv)
        addParameter("pin_num", value: registration.passcode)
        addParameter("phone_num", value: registration.phoneNumber)
        addParameter("zipcode", value: registration.zipcode)
        addParameter("action", value: "register")
        print(registration)
        networkRequest(registrationConfirmed)
    }
    
    func undoRegisterUser(registration: Registration)
    {
        addParameter("action", value: "undo_register_user")
        addParameter("phone_num", value: registration.phoneNumber)
        networkRequest(undoRegisterUserConfirmed)
    }
    
    func undoRegisterUserConfirmed(jsonData: JSON)
    {
        
    }
    
    func registrationConfirmed(jsonData: JSON)
    {
        //print("Registration Confirmed")
    }
    
    func registrationErrorInvalidCard(){
        //errorAlert("There was a problem reading your credit card.  Please swipe it again", okText: "Retry", cancelText: "Cancel")
    }
    
    func registrationErrorInvalidZipcode(){
        
    }
    
    func registrationErrorInvalidCCV(){
        
    }
    
    func registrationErrorExpiredCard(){
        
    }
    
    func registrationErrorUnsupportedCard(){
        
    }
    
    func registrationErrorAccountAlreadyExists(){
        
    }
    
    func loginErrorAccountDoesNotExist(){
    
    }
    
    func loginErrorInvalidPasscode(){
        
    }
    
    /* Errors */
    /*
    Errors
    
    401     No action identifier in json
    402     No phone number
    403     No pin num
    404     Phone number is too short
    405     Phone number is too long
    500     Unknown exception or unable to connect to database
    501     Authenticate:   no such user
    502     Authenticate:   passcode is incorrect
    506     Authenticate:   user already registered
    600     Token Charge:   Invalid phone number
    601     Token Charge:   Invalid pin number
    610     Token Charge:   No token hex provided
    611     Token Charge:   Unable to charge token
    602     Token Registration:   No credit card provided
    603     Token Registration:   No expiration date
    604     Token Registration:   Invalid zip code
    605     Token Registration:   Invalid CCV Code
    610     Token Registration:   Unable to obtain token
    612     Token Registration:   Problem obtaining token
    */
    
    var errorDescriptions: Dictionary = Dictionary<Int, String>()
    
    func noActionIdentifier()
    {
        // Error 401
        // No action identifier in json
    }
    
    func noPhoneNumber()
    {
        // Error 402
        // No phone number
    }
    
    func noPasscode()
    {
        // Error 403
        // No pin num
    }
    
    func phoneNumberTooShort()
    {
        // Error 404
        // Phone number is too short
    }
    
    func phoneNumberTooLong()
    {
        // Error 405
        // Phone number is too long
    }
    
    func unknownException()
    {
        // Error 500
        // Unknown Exception
    }
    
    func noSuchUser()
    {
        // Error 501
        // No such user
    }
    
    func passcodeIncorrect()
    {
        // Error 502
        // pin_num does not match
    }
    
    func userAlreadyRegistered()
    {
        // Error 506
        // User already registered
    }
    
    func noCreditCardProvided()
    {
        // Error 602
        // No credit card provided
    }
    
    func noExpirationDateProvided()
    {
        // Error 603
        // No Expiration Date provided
    }
    
    func invalidZipCode()
    {
        // Error 604
        // Invalid zip code
    }
    
    func invalidCCVCode()
    {
        // Error 605
        // Invalid CCV provided
    }
    
    func noTokenHexProvided()
    {
        // Error 610
        // No Token Hex Provided
    }
    
    func unableToChargeToken()
    {
        // Error 611
        // Unable to charge token
    }    
    
}

/*


*/