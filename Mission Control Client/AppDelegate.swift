//
//  AppDelegate.swift
//  Mission Control Client
//
//  Created by Joe Longstreet on 3/15/16.
//  Copyright © 2016 Joe Longstreet. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {
    
    // remote locations for javascript files
    static let TVBaseURL = "http://localhost:3000/"
    static let TVBootURL = "\(AppDelegate.TVBaseURL)tvos.js"
    
    var window: UIWindow?
    var appController: TVApplicationController?
    
    // create an interface factory to utilize custom fonts
    let interfaceFactory = TVInterfaceFactory.sharedInterfaceFactory().extendedInterfaceCreator = TVExtendedInterfaceCreator()
    
    // populate with contents of javascript file
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let appControllerContext = TVApplicationControllerContext()
        if let javaScriptURL = NSURL(string: AppDelegate.TVBootURL) {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        appControllerContext.launchOptions["BASEURL"] = AppDelegate.TVBaseURL
        if let launchOptions = launchOptions as? [String: AnyObject] {
            for (kind, value) in launchOptions {
                appControllerContext.launchOptions[kind] = value
            }
        }
        appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
        
        return true
    }

    func appController(appController: TVApplicationController, didFinishLaunchingWithOptions options: [String: AnyObject]?) {
        print("\(__FUNCTION__) invoked with options: \(options)")
    }
    
    func appController(appController: TVApplicationController, didFailWithError error: NSError) {
        print("\(__FUNCTION__) invoked with error: \(error)")
        
        let title = "Error Launching Application"
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.Alert )
        
        self.appController?.navigationController.presentViewController(alertController, animated: true, completion: { () -> Void in
            // ...
        })
    }
    
    func appController(appController: TVApplicationController, didStopWithOptions options: [String: AnyObject]?) {
        print("\(__FUNCTION__) invoked with options: \(options)")
    }
}