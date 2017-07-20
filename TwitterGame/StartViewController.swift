//
//  StartViewController.swift
//  
//
//  Created by Miguel Tepale on 7/20/17.
//
//

import UIKit
import TwitterKit

class StartViewController: UIViewController {
    
        let client = TWTRAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         Do any additional setup after loading the view.
        
                let client = TWTRAPIClient()
                let tweetIDs = ["20", "510908133917487104"]
                client.loadTweets(withIDs: tweetIDs) { (tweets, error) -> Void in
                    // handle the response or error
                    //print(tweets)
                }
    }
}
