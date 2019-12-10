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
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
}
