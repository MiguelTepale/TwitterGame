//
//  GameViewController.swift
//  TwitterGame
//
//  Created by Miguel Tepale on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testSentimentAnalysis()
    }
    
    func testSentimentAnalysis() {
        
        
        let urlString = "https://twinword-sentiment-analysis.p.mashape.com/analyze/?text=great+value+in+its+price+range!"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.setValue("X-Mashape-Key", forHTTPHeaderField: "hGaVDVWgzMmsh6XN8RaifWxSAjKop1vUECRjsnXRPzlJAyJiWS")
        request.setValue("Accept", forHTTPHeaderField: "application/json")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let urlData = data, error == nil else {
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: urlData, options: .mutableLeaves)
            
            print(json!)
        }
        .resume()
    }
}
