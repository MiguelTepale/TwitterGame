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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var playBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.activityIndicator.startAnimating()
        self.playBtn.isEnabled = false
        
        mysharedManager.loadDataFromTxtFile()

        mysharedManager.downloadTweets(completion: {
            self.mysharedManager.getSentiments()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.playBtn.isEnabled = true
            }
        })
        
        
        
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        if mysharedManager.tweetsArray.count != 0 {
            self.performSegue(withIdentifier: "segueToGameVC", sender: self)
        } else {
            self.activityIndicator.startAnimating()
            self.playBtn.isEnabled = false
            
            Utilities.downloadTwitterData(handle: mysharedManager.getRandomHandle(), completion: { (tweets) in
                    self.mysharedManager.tweetsArray = tweets
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.playBtn.isEnabled = true
                }
            })
        }
    }
}
