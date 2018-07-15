//
//  SignInViewController.swift
//  Techlab-Coin
//
//  Created by Hoang Trong Anh on 14/07/2018.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class SignInViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginByGmail(_ sender: UIButton) {
        GmailClass.sharedInstance().loginWithGmail(viewController: self, successHandler: { (response) in
            debugPrint("Gmail response : \(response)")
        }, failHandler: { (failResponse) in
            debugPrint("Gmail error !")
        })
    }
    
    @IBAction func loginByFacebook(_ sender: UIButton) {
        FacebookClass.sharedInstance().loginWithFacebook(viewController: self, successHandler: { (response) in
            
        }) { (fail) in
            
        }
    }
    
    @IBAction func loginByTwitter(_ sender: UIButton) {
        TwitterClass.sharedInstance().loginWithTwitter(viewController: self, successHandler: { (response) in
            debugPrint("Twitter response : \(response)")
        }, failHandler: { (failResponse) in
            debugPrint("Twitter error !")
        })
    }
    @IBAction func login(_ sender: UIButton) {
        self.transitionToHome()
    }
    func transitionToHome() {
        let tabBarController = ESTabBarController()
        if let tabBar = tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let v1 = main.instantiateViewController(withIdentifier: "WalletsViewController") as! WalletsViewController
        let v2 = main.instantiateViewController(withIdentifier: "PriceHistoryViewController") as! PriceHistoryViewController
        
        v1.tabBarItem = ESTabBarItem.init(title: "Wallet", image: UIImage(named: "wallet"), selectedImage: UIImage(named: "wallet"))
        v2.tabBarItem = ESTabBarItem.init(title: "History", image: UIImage(named: "history"), selectedImage: UIImage(named: "history"))
        let n1 = NavigationController.init(rootViewController: v1)
        let n2 = NavigationController.init(rootViewController: v2)
        
        v1.title = "Wallet"
        v2.title = "History"
        
        tabBarController.viewControllers = [n1, n2]
        
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return
        }
        
        tabBarController.view.frame = rootViewController.view.frame
        tabBarController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: { completed in
            // maybe do something here
        })
        
    }
}
