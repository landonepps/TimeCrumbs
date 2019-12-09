//
//  MeetTheTeamTableViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class MeetTheTeamTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url: URL?
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                url = URL(string: "https://www.linkedin.com/in/austin-goetz-4104a7117/")
            case 1:
                url = URL(string: "https://www.linkedin.com/in/landonepps/")
            default:
                return
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                url = URL(string: "https://www.linkedin.com/in/elimishawilliams/")
            case 1:
                url = URL(string: "https://www.linkedin.com/in/kylebaughan/")
            case 2:
                url = URL(string: "https://www.linkedin.com/in/natalie-d-isaacson-4a7a6976/")
            default:
                return
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                url = URL(string: "https://www.linkedin.com/in/eric-baker-15b8b450/")
            case 1:
                url = URL(string: "https://www.linkedin.com/in/lyndsi-littlefield-a21503195/")
            case 2:
                url = URL(string: "https://www.linkedin.com/in/mallory-mathews-5b167193/")
            default:
                return
            }
            case 3:
                switch indexPath.row {
                case 0:
                    url = URL(string: "https://www.linkedin.com/in/ryangreenburg/")
                default:
                    return
                }
        default:
            return
        }
        
        if url != nil {
            UIApplication.shared.open(url!)
        }
    }
    
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
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
    
}
