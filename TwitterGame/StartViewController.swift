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
    
    let mysharedManager = DAO.sharedManager
//    var bgMusic = NSURL(fileURLWithPath:Bundle.main.path(forResource:"Aerosmith - Sweet Emotion", ofType: "mp3")!)
//    var audioPlayer = AVAudioPlayer()

    
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
        
//        audioPlayer = try! AVAudioPlayer(contentsOf: bgMusic as URL)
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
//        audioPlayer.numberOfLoops = -1
        
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
