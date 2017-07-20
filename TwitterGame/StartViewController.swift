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
        
    }
}
