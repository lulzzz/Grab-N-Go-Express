//
//  AppDelegate.swift
//  Grab n Go Express
//
//  Created by Adam Arthur on 10/13/15.
//  Copyright © 2015 Adam Arthur. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate2: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    enum deviceType {
        case iPad
        case iPadMini
        case iPhone
        case iPhone3
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case unsupportedDevice
        case simulator
    }
    
    
    var currentDevice: deviceType {
        
        // For development only.
        // return deviceType.iPhone4
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            return deviceType.iPad
        }
        else
        {
            return deviceType.iPhone
        }
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("")
            {
                identifier, element in
                guard let value = element.value as? Int8 where value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return deviceType.iPhone
        case "iPod7,1":                                 return deviceType.iPhone
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return deviceType.iPhone
        case "iPhone4,1":                               return deviceType.iPhone
        case "iPhone5,1", "iPhone5,2":                  return deviceType.iPhone
        case "iPhone5,3", "iPhone5,4":                  return deviceType.iPhone
        case "iPhone6,1", "iPhone6,2":                  return deviceType.iPhone
        case "iPhone7,2":                               return deviceType.iPhone
        case "iPhone7,1":                               return deviceType.iPhone
        case "iPhone8,1":                               return deviceType.iPhone
        case "iPhone8,2":                               return deviceType.iPhone
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return deviceType.iPad
        case "iPad3,1", "iPad3,2", "iPad3,3":           return deviceType.iPad
        case "iPad3,4", "iPad3,5", "iPad3,6":           return deviceType.iPad
        case "iPad4,1", "iPad4,2", "iPad4,3":           return deviceType.iPad
        case "iPad5,1", "iPad5,3", "iPad5,4":           return deviceType.iPad
        case "iPad2,5", "iPad2,6", "iPad2,7":           return deviceType.iPad
        case "iPad4,4", "iPad4,5", "iPad4,6":           return deviceType.iPad
        case "iPad4,7", "iPad4,8", "iPad4,9":           return deviceType.iPad
        case "iPad5,1", "iPad5,2":                      return deviceType.iPad
        case "i386", "x86_64":                          return deviceType.iPhone
        default:                                        return deviceType.iPhone
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let iPhoneView: loginView = loginView()
        let iPadView: LoginView = LoginView()
        
        if(currentDevice == deviceType.iPhone)
        {
        if let window = self.window{
            window.rootViewController = iPhoneView
        }
        window?.rootViewController = iPhoneView
        }
        
        if(currentDevice == deviceType.iPad)
        {
            if let window = self.window{
                window.rootViewController = iPadView
            }
            window?.rootViewController = iPadView
        }
        
        window?.makeKeyAndVisible()
        return true
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Atom-Creative.Grab_n_Go_Express" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Grab_n_Go_Express", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}

