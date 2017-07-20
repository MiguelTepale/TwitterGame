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
    
    let mysharedManager = DAO.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mysharedManager.downloadTweets()
        initiateSentimentAnalysisAPI()
    }
    
    func initiateSentimentAnalysisAPI() {
        
        let urlString = "https://twinword-sentiment-analysis.p.mashape.com/analyze/?text=great+value+in+its+price+range!"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.setValue("hGaVDVWgzMmsh6XN8RaifWxSAjKop1vUECRjsnXRPzlJAyJiWS", forHTTPHeaderField: "X-Mashape-Key")
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
            guard let keywords = json?["keywords"] as! [[String:Any]]? else {
                print("'Keywords' value is nil")
                return
            }
            
            for values in keywords {
                //keyword = e.g.[great,price,value,range]
                guard let keyword = values["word"] as! String? else {
                    return
                }
            }
            
            
            }
            .resume()
    }
}
