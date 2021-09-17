//
//  ThirdViewController.swift
//  QuoteManagerV2
//
//  Created by Anthony Valenti on 2021-05-11.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var jobs: [String] =         UDM.shared.defaults.object(forKey: "upcomingJobs") as? [String] ?? [String]()
    var selectedCell = -1
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    
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
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if (selectedCell != -1){
            jobs.remove(at: selectedCell)
            UDM.shared.defaults.removeObject(forKey: "upcomingJobs")
            UDM.shared.defaults.setValue(jobs, forKey: "upcomingJobs")
            tableView.reloadData()
       }
    }
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        if (selectedCell != -1){
            var tempArr: [String] = [String]()
            tempArr.append(jobs[selectedCell])
            UDM.shared.defaults.setValue(tempArr, forKey: "pastJobs")
            jobs.remove(at: selectedCell)
            UDM.shared.defaults.removeObject(forKey: "upcomingJobs")
            UDM.shared.defaults.setValue(jobs, forKey: "upcomingJobs")
            tableView.reloadData()
        }
    }
    

   

}
