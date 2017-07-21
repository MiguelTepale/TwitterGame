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
    
    let mysharedManager = DAO.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        guard let author = mysharedManager.tweeter else { return }
        tweetLabel.text = (tweet?.tweetStr)! + "\n- \(author)"
        guard let status = tweet?.statusOfTweet else { return }
        guard let yourAns = tweet?.userChoice else { return }
        var analysisText = "Tweet: \(status)\nYour Answer: \(yourAns)\n\n"
        for key in (tweet?.tweetBreakup.keys)! {
            guard let text = tweet?.tweetBreakup[key] else { return }
            analysisText += "\(key): \(text)\n"
        }
        if tweet?.tweetBreakup.count == 0 {
            analysisText += "There is nothing to be analyzed!"
        }
        analysisLabel.text = analysisText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
