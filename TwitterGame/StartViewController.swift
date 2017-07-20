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

//    let client = TWTRAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let client = TWTRAPIClient()
        let tweetIDs = ["20", "510908133917487104"]
        client.loadTweets(withIDs: tweetIDs) { (tweets, error) -> Void in
            // handle the response or error
            //print(tweets)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
