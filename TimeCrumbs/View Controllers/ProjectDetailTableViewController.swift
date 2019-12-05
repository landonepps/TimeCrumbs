//
//  ProjectDetailTableViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/3/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ProjectDetailTableViewController: UITableViewController {
    
    var project: Project?
    
    // MARK: - Outlets
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var chargeRateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectDetailCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helper Functions
    func updateViews() {
        
        guard let project = project else { return }
        
        if let projectColorName = project.color,
            let projectColor = UIColor(named: projectColorName) {
            projectNameLabel.textColor = projectColor
        }
        
        projectNameLabel.text = project.name
        clientNameLabel.text = project.clientName
        chargeRateLabel.text = "\(project.rate)/hr"
    }
}
