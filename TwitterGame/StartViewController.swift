//
//  StartViewController.swift
//  
//
//  Created by Miguel Tepale on 7/20/17.
//
//

import UIKit
import TwitterKit
import AVFoundation

class StartViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var playBtn: UIButton!
    
    var status = Reachability.status()
    
    let mysharedManager = DAO.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.activityIndicator.startAnimating()
        self.playBtn.isEnabled = false
        
        mysharedManager.loadDataFromTxtFile()
        
        audioPlayer = try! AVAudioPlayer(contentsOf: bgMusic as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
        
        if status == .reachable {
            mysharedManager.downloadTweets(completion: {
                self.mysharedManager.getSentiments()
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.playBtn.isEnabled = true
                }
            })
        } else {
            let alert = UIAlertController(title: "Error, No Network!", message: "Please check your network settings.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: {
                self.activityIndicator.stopAnimating()
                self.playBtn.isEnabled = true
            })
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        status = Reachability.status()
        
        if status == .reachable {
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
        } else {
            let alert = UIAlertController(title: "Error, No Network!", message: "Please check your network settings.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: {
                self.activityIndicator.stopAnimating()
                self.playBtn.isEnabled = true
            })
        }
    }
}
