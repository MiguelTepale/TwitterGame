//
//  DetailViewController.swift
//  TwitterGame
//
//  Created by Miguel Tepale on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweet: Tweet?
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var analysisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetLabel.text = tweet?.tweetStr
        
        for key in (tweet?.tweetBreakup.keys)! {
            analysisLabel.text = "\(key): \(tweet?.tweetBreakup.)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
