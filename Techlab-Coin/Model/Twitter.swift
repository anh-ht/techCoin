//
//  Twitter.swift
//  Techlab-Coin
//
//  Created by Hoang Trong Anh on 14/07/2018.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import Foundation

import UIKit
import TwitterKit
import Fabric

class TwitterClass: NSObject {
    
    var AppConsumerKey: String = "LBJskZi2ksL7s2lLhS6LzavgW"
    var AppSecrat: String = "RYAcPExR6NI7c3scO6msVg0SLd9F5Ea4G1OIb3swzr2Qefrj1X"
    var strUserId: String = ""
    
    typealias TWSuccessHandler = (_ success:AnyObject) -> Void
    typealias TWFailHandler = (_ success:AnyObject) -> Void
    
    var vc: UIViewController!
    var loginFail: TWFailHandler?
    var loginSucess: TWSuccessHandler?
    
    
    static var twitterClass: TwitterClass!
    
    class func sharedInstance() -> TwitterClass {
        
        if(twitterClass == nil) {
            twitterClass = TwitterClass()
        }
        return twitterClass
    }
    
    
    
    func loginWithTwitter(viewController: UIViewController, successHandler: @escaping TWSuccessHandler, failHandler: @escaping TWFailHandler) {
        
        vc = viewController
        loginFail = failHandler
        loginSucess = successHandler
        
        if(Reachability.isNetworkAvailable()) {
            
            TWTRTwitter.sharedInstance().start(withConsumerKey: AppConsumerKey, consumerSecret: AppSecrat)
            
            TWTRTwitter.sharedInstance().logIn(with: vc) { (session, error) in
                if((session) != nil) {
                    
                    TWTRTwitter.sharedInstance().sessionStore.saveSession(withAuthToken: (session?.authToken)!, authTokenSecret: (session?.authTokenSecret)!, completion: { (session, error) in
                        
                    })
                    
                    
                    TWTRAPIClient.withCurrentUser().requestEmail(forCurrentUser: { (email, error) in
                        print(email)
                    })
                    self.strUserId = (session?.userID)!
                    
                    print("authToken    :\(session?.authToken)")
                    print("userName     :\(session?.userName)")
                    
                    print("userID       :\(self.strUserId)")
                    
                    self.loginSucess!(session as AnyObject)
                    self.getAccountInfo(userID: self.strUserId)
                }
                else {
                    self.loginFail!(error?.localizedDescription as AnyObject)
                }
                
            }
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
        
    }
    
    func getAccountInfo(userID: String) {
        let statusesShowEndpoint = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let params = ["user_id": userID]
        
        var clientError : NSError?
        
        let request = TWTRAPIClient.withCurrentUser().urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)

        TWTRAPIClient.withCurrentUser().sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("json: \(json)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    
    func logoutFromTwitter() {
        
        if(Reachability.isNetworkAvailable()) {
            TWTRTwitter.sharedInstance().sessionStore.logOutUserID(self.strUserId)
        }
        else {
            print("No internet Connection.")
            self.loginFail!("No internet Connection." as AnyObject)
        }
    }
    
}

