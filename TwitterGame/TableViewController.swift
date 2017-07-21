//
//  TableViewController.swift
//  TwitterGame
//
//  Created by Miguel Tepale on 7/20/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let mysharedManager = DAO.sharedManager
    
    var selectedTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mysharedManager.tweetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Tweet # \(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTweet = mysharedManager.tweetsArray[indexPath.row]
        self.performSegue(withIdentifier: "pushToDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passing Tweet object to DetailVC
        if segue.identifier == "pushToDetailVC" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.tweet = selectedTweet
            }
        }
    }

}
