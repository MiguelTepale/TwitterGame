//
//  DAO.swift
//  TwitterGame
//
//  Created by Andy Wu on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import Foundation


class DAO {
    static let sharedManager = DAO()
    
    var tweetsArray = [Tweet]()
    var twitterHandles = [String]()
    var numCorrect = 0
    
    
    func downloadTweets(completion: @escaping () -> ()) {
        let randomHandle = getRandomHandle()
        Utilities.downloadTwitterData(handle: randomHandle, completion: { (tweets) in
            self.tweetsArray = tweets
            completion()
        })
    }
    
    func getSentiments() {
        for tweet in tweetsArray {
            Utilities.initiateSentimentAnalysisAPI(tweet: tweet)
        }
    }
    
    func getRandomHandle() -> String {
        let index = Int(arc4random_uniform(UInt32(twitterHandles.count)))
        return twitterHandles[index]
    }
    
    func loadDataFromTxtFile() {
        let filename = "ListOfNames"
        
        if let path = Bundle.main.path(forResource: filename, ofType: nil) {
            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                let handles = text.components(separatedBy: "\n")
                
                for name in handles {
                    self.twitterHandles.append(name)
                }
                
            } catch {
                print("Failed to read text")
            }
        } else {
            print("Failed to load file from app bundle")
        }
    }
}
