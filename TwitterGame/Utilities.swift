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
        let endpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=realDonaldTrump&count=2"
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
                print("\n" + newTweet.tweetStr + "\n")
            }
            completion(tweetArr)
        }
    }
    
    static func initiateSentimentAnalysisAPI(tweet:Tweet) {
        
        let text = tweet.tweetStr
        
        let urlComponents = NSURLComponents(string: "https://twinword-sentiment-analysis.p.mashape.com/analyze/")!
        
        //Add the text Parameters
        urlComponents.queryItems = [
            NSURLQueryItem(name: "text", value: text) as URLQueryItem
        ]
        
        guard let url = urlComponents.url
            else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("hGaVDVWgzMmsh6XN8RaifWxSAjKop1vUECRjsnXRPzlJAyJiWS", forHTTPHeaderField: "X-Mashape-Key")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let urlData = data, error == nil else {
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: urlData) as? [String: AnyObject] else {
                return
            }
            //Sentiment = [postive,negative,neutral]
            guard let sentiment = json?["type"] as! String? else{
                print("'Sentiment' value is nil")
                return
            }
            
            tweet.statusOfTweet = sentiment
            
            guard let keywords = json?["keywords"] as! [[String:Any]]? else {
                print("'Keywords' value is nil")
                return
            }
            
            for values in keywords {
                //keyword = e.g.[great,price,value,range]
                guard let word = values["word"] as! String? else {
                    return
                }
                guard let score = values["score"] as! Double? else {
                    return
                }
                
                tweet.tweetBreakup[word] = String(score)
            }
            print("Tweet Makeup: \(tweet.tweetBreakup)")
            print("Sentiment: \(String(describing: tweet.statusOfTweet))\n")
        }.resume()
    }
}
