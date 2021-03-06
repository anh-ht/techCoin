//
//  AppDelegate.swift
//  Techlab-Coin
//
//  Created by Hoang Trong Anh on 6/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import TwitterKit
import FirebaseCore
import Google
import GoogleSignIn
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
//        'You must specify |clientID| for |GIDSignIn|'
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = main.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        window                      = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController  = vc
        window?.backgroundColor     = UIColor.white
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        if(LISDKCallbackHandler.shouldHandle(url)) {
//            return LISDKCallbackHandler.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        }
        
        if TWTRTwitter.sharedInstance().application(app, open:url, options: options) {
            return true
        }
        
        if(url.scheme == "fb173382236861611") { //Facebook
            
            //            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        else { //Gmail
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        
    }
    


}

