//
//  GameViewController.swift
//  TwitterGame
//
//  Created by Miguel Tepale on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var tweetLbl: UILabel!
    
    let mysharedManager = DAO.sharedManager
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetLbl.text = mysharedManager.tweetsArray[index].tweetStr
        
    }
    
    @IBAction func positiveButton(_ sender: Any) {
        getNextTweet()
    }
    
    @IBAction func neutralButton(_ sender: Any) {
        
    }
    
    @IBAction func negativeButton(_ sender: Any) {
        
    }
    
    func getNextTweet() {
        if index < mysharedManager.tweetsArray.count - 1 {
            index += 1
            tweetLbl.text = mysharedManager.tweetsArray[index].tweetStr
        } else {
            print("Game Over!")
        }
        
    }
    
}
