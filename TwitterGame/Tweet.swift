//
//  Tweet.swift
//  TwitterGame
//
//  Created by Andy Wu on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import Foundation


class Tweet {
    var tweetStr: String
    var statusOfTweet: String?
    var userChoice: String?
    var isCorrect: Bool?
    var tweetBreakup = [String:String]()
    
    init(tweet:String) {
        self.tweetStr = tweet
    }
}
