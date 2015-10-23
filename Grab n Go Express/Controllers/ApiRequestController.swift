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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}

/*

	
*/