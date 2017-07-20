//
//  Utilities.swift
//  TwitterGame
//
//  Created by Andy Wu on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import Foundation
import TwitterKit


class Utilities {
    static func downloadTwitterData(handle:String, completion: @escaping(_ tweets: [Tweet]) -> ()) {
        var tweetArr = [Tweet]()
        let client = TWTRAPIClient()
        let endpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(handle)&count=2"
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: nil, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError ?? "IUNNO" as! Error)")
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data!) as? [[String: AnyObject]]
                else {return}
            for element in json! {
                let newTweet = Tweet(tweet: element["text"] as! String)
                tweetArr.append(newTweet)
                print(newTweet.tweetStr + "\n")
            }
            completion(tweetArr)
        }
    }
    
    
}
