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
    
    
    func downloadTweets() {
        Utilities.downloadTwitterData(completion: { (tweets) in
            self.tweetsArray = tweets
        })
    }
}
