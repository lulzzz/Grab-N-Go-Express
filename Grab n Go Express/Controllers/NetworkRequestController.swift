//
//  NetworkRequestController.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/14/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

//  This class controls the sending og HTTP requests to and from the server
//  References this tutorial
//  http://jamesonquave.com/blog/making-a-post-request-in-swift/

import UIKit

class NetworkRequestController: UIElementController {

    
    var urlResource = "http://www.atomcreativecorp.com/adamsapps/1.1/adamsapps.php"
    // 166.78.61.142
    // This is going to evolve into a REST Compliant resource, which
    // currently it is not.
    
    var httpBody: String = ""
    var jsonDataObj: Dictionary = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is expected to be called by a subclass
    func setResource(urlResource: String)
    {
        self.urlResource = urlResource
    }

    func addParameter(parameter: String, value: String)
    {
        jsonDataObj[parameter] = value
    }
    
    func resetJsonObj()
    {
        jsonDataObj.removeAll()
    }
    
    func networkRequest(completion: (JSON) -> Void)
    {
        networkRequest(completion, timeout: timeout)
    }
    
    func networkRequest(completion: (JSON) -> Void, timeout: () -> Void)
    {
        addParameter("location_upc_identifier", value: "10000000020")
        
        let params = jsonDataObj
        
        print(params)
        //let jsonData = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        let request = NSMutableURLRequest(URL: NSURL(string: urlResource)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        request.timeoutInterval = 10
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch {
            //print("Error was received")
            //print(error)
        }
        
        print("Going to call dataTaskWithRequest\r\n")
        
        //print(request)
        //print(request.HTTPBody)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:
            {
                data, response, error in

                if error != nil {
                    print(error!.localizedDescription)
                    dispatch_async(dispatch_get_main_queue(), {
                        timeout()
                    })
                    
                    
                    
                } else {
                    print("Completion function called")
                    let json = JSON(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        print(json)
                        completion(json)
                        
                    })
                    
                }
        })
        
        //print("Task.resume called\r\n")
        task.resume() //Tasks are called with .resume()
    }
    
    func timeout()
    {
        
        //var jsonString = "{ \"Error\":\"0\" }";
        //let json = JSON(data: jsonString)
        //print(json)
        //completion(0)
    }
    
    func errorExit()
    {
        // Check for errors in the required parameters, and exit if given
    }
}
