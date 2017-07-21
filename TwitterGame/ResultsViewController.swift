//
//  ResultsViewController.swift
//  TwitterGame
//
//  Created by Miguel Tepale on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var keepScoreLabel: UILabel!
    
    let mysharedManager = DAO.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        keepScoreLabel.text = "\(mysharedManager.numCorrect)/\(mysharedManager.tweetsArray.count)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func analyzeTweetButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToTableVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToTableVC" {
            
            let backItem = UIBarButtonItem()
            backItem.title = "Game"
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        let status = Reachability.status()
        
        if status == .reachable {
            self.mysharedManager.tweetsArray.removeAll()
            self.mysharedManager.numCorrect = 0
            self.mysharedManager.downloadTweets(completion: {
                self.mysharedManager.getSentiments()
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            let alert = UIAlertController(title: "Error, No Network!", message: "Please check your network settings.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
