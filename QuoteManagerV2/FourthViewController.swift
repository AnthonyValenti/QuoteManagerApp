//
//  FourthViewController.swift
//  QuoteManagerV2
//
//  Created by Anthony Valenti on 2021-05-11.
//

import UIKit

class FourthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    var jobs: [String] =         UDM.shared.defaults.object(forKey: "pastJobs") as? [String] ?? [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    //Methods for tableView
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobs.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.jobs[indexPath.row]
        
        return cell
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        jobs.removeAll()
        UDM.shared.defaults.removeObject(forKey: "pastJobs")
        tableView.reloadData()
    }
    
 
    
    



}
