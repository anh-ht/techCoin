//
//  ViewController.swift
//  Techlab-Coin
//
//  Created by Hoang Trong Anh on 6/29/18.
//  Copyright © 2018 Hoang Trong Anh. All rights reserved.
//

import UIKit
import APIKit
import JSONRPCKit

class WalletsViewController: UIViewController {
    
    // mark : variables
    let batchFactory = BatchFactory(version: "2.0", idGenerator: NumberIdGenerator())
    
    var wallets: [String: String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getAccounts()
    }
    
    private func getBalanceAccount(byAddress: String) {
        
    }
    
    private func getAccounts() {
        let request = EthGetAccounts()
        
        let batch = batchFactory.create(request)
        let httpRequest = EthServiceRequest(batch: batch)
        
        Session.send(httpRequest, callbackQueue: nil) { (result) in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

