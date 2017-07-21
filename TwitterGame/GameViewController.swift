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
    
    var currentTweet:Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTweet = mysharedManager.tweetsArray[index]
        
        tweetLbl.text = mysharedManager.tweetsArray[index].tweetStr
        
    }
    
    @IBAction func positiveButton(_ sender: Any) {
        mysharedManager.tweetsArray[index].userChoice = "Positive"
        if currentTweet?.statusOfTweet?.lowercased() == "positive" {
            mysharedManager.tweetsArray[index].isCorrect = true
            mysharedManager.numCorrect += 1
        }
        getNextTweet()
    }
    
    @IBAction func neutralButton(_ sender: Any) {
        mysharedManager.tweetsArray[index].userChoice = "Neutral"
        if currentTweet?.statusOfTweet?.lowercased() == "neutral" {
            mysharedManager.tweetsArray[index].isCorrect = true
            mysharedManager.numCorrect += 1
        }
        getNextTweet()
    }
    
    @IBAction func negativeButton(_ sender: Any) {
        mysharedManager.tweetsArray[index].userChoice = "Negative"
        if currentTweet?.statusOfTweet?.lowercased() == "negative" {
            mysharedManager.tweetsArray[index].isCorrect = true
            mysharedManager.numCorrect += 1
        }
        getNextTweet()
    }
    
    func getNextTweet() {
        if index < mysharedManager.tweetsArray.count - 1 {
            index += 1
            tweetLbl.text = mysharedManager.tweetsArray[index].tweetStr
            currentTweet = mysharedManager.tweetsArray[index]
        } else {
            print("Game Over!")
            let resultsVC:UIViewController = UIStoryboard(name: "Results", bundle: nil).instantiateViewController(withIdentifier: "ResultsVC") as UIViewController
            self.present(resultsVC, animated: false, completion: nil)
        }
        
    }
    
}
