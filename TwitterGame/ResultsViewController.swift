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
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: {
            self.mysharedManager.tweetsArray.removeAll()
            self.mysharedManager.numCorrect = 0
            self.mysharedManager.downloadTweets(completion: {
                self.mysharedManager.getSentiments()
            })
        })
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
