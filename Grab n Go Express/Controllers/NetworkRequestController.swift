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

    //#if DEBUG
        var urlResource = "https://www.atomcreativecorp.com/adamsapps/SelfCheckout/Production/2.0/SelfCheckout.php"
    //#else
        //var urlResource = "http://166.78.61.142/adamsapps/SelfCheckout/Production/2.0/SelfCheckout.php"
    //#endif
    
    // 166.78.61.142
    // This is going to evolve into a REST Compliant resource, which
    // currently it is not.
    
    var httpBody: String = ""
    //var jsonDataObj: Dictionary = Dictionary<String, AnyObject>()
    var jsonDataObj = [String : AnyObject]()
   
    var networkLoadingView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkLoadingView.frame  = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
        networkLoadingView.backgroundColor = UIColor.orange
        networkLoadingView.text = "Loading"
        networkLoadingView.textAlignment = .center
        networkLoadingView.isHidden = false
        networkLoadingView.textColor = UIColor.white
        view.addSubview(networkLoadingView)
        // Do any additional setup after loading the view.
    }

    func displayLoading()
    {
        view.bringSubview(toFront: networkLoadingView)
        UIView.animate(withDuration: 0.3, delay: 1.0,
            options: .curveEaseOut, animations: {
                self.networkLoadingView.frame = CGRect(x: 0, y: self.view.frame.height-25, width: self.view.frame.width, height: 25)
            }, completion: nil)
        
    }
    
    func hideLoading()
    {
        UIView.animate(withDuration: 0.3, delay: 0.0,
            options: .curveEaseOut, animations: {
                self.networkLoadingView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is expected to be called by a subclass
    func setResource(_ urlResource: String)
    {
        self.urlResource = urlResource
    }

    func addParameter(_ parameter: String, value: AnyObject)
    {
        jsonDataObj[parameter] = value
    }
    
    func resetJsonObj()
    {
        jsonDataObj.removeAll()
    
    }
    
    func networkRequest(_ completion: @escaping (JSON) -> Void)
    {
        networkRequest(completion, timeout: timeout)
    }
    
    var retryRequests: Int = 0;
    
    func networkRequest(_ completion: @escaping (JSON) -> Void, timeout: @escaping () -> Void)
    {
        
        //#if DEBUG
            let locationSerial: String = UserDefaults.standard.object(forKey: "location_serial") as! String!
            if locationSerial == "0"
            {
                print("We're going to have a problem...start the configuration view")
            }
        
            print("location_serial" + locationSerial)
            //#else
            //   let locationSerial: String = "10000000020";
        
        //NSUserDefaults.standardUserDefaults().objectForKey("location_serial") as! String!
        //#endif
        
        addParameter("location_upc_identifier", value: locationSerial as AnyObject)
        
        let params = jsonDataObj
        //print(params) as! AnyObject
        //let jsonData = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        let request = NSMutableURLRequest(url: URL(string: urlResource)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        
        
        print("---here---")
        print( JSON(params) );
        print("---here 2---");
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        } catch {
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
            {
                data, response, error in

                print(error)
                if error != nil {
                    DispatchQueue.main.async(execute: {
                        timeout()
                        
                        self.retryRequests = self.retryRequests + 1;
                        if(self.retryRequests < 3)
                        {
                            self.networkRequest(completion)
                        }
                    })

                } else {
                    // Should put this in a try catch
                    let json = JSON(data: data!)
                    self.retryRequests = 0;
                    DispatchQueue.main.async(execute: {
                        self.hideLoading()
                        print(json)
                        completion(json)
                        
                    })
                    
                }
        })

        task.resume()
        self.displayLoading()
    }
    
    func timeout()
    {
        hideLoading()
    }
    
    func errorExit()
    {
        // Check for errors in the required parameters, and exit if given
    }
}
