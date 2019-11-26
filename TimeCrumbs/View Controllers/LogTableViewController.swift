//
//  LogTableViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

fileprivate let reuseIdentifier = "TaskCell"

class LogTableViewController: UITableViewController {
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let buttonView = makeExportButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonView)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    // MARK: - Helpers
    
    func makeExportButton() -> UIView {
        let buttonView = UIView()
        
        // Set up subviews
        let imageView = UIImageView(image: UIImage(systemName: "square.and.arrow.down"))
        let label = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        
        label.text = "Export"
        label.textColor = UIColor.systemBlue
        
        // Add constraints
        imageView.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: buttonView.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: buttonView.rightAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        
        buttonView.sizeToFit()
        
        return buttonView
    }

}

extension LogTableViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
