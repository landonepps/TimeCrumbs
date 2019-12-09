//
//  ProjectDetailTableViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/3/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

class ProjectDetailTableViewController: UITableViewController {
    
    var project: Project!
    var fetchedResultsController: NSFetchedResultsController<Task>?
    
    // MARK: - Outlets
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var chargeRateLabel: UILabel!
    
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPredicate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        updateViews()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectDetailCell", for: indexPath) as? ProjectDetailTableViewCell
            else { fatalError("Cell with identifier ProjectDetailCell is not of type ProjectDetailViewCell") }
        
        if let task = fetchedResultsController?.object(at: indexPath) {
            cell.update(with: task)
        }
        
        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditProject" {
            guard let destination = segue.destination as? AddProjectViewController,
                let project = project
                else { return }
            
            destination.project = project
        }
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let project = project else { return }
        
        if let projectColorName = project.color,
            let projectColor = UIColor(named: projectColorName) {
            projectNameLabel.textColor = projectColor
        }
        
        projectNameLabel.text = project.name
        clientNameLabel.text = project.clientName
        chargeRateLabel.text = "\(project.rate?.asCurrency() ?? "")" + (project.isHourly ? "/h" : " fixed")
    }
    
    func setUpPredicate() {
        let request = Task.sortedFetchRequest
        request.predicate = NSPredicate(format: "project == %@", project)
        
        let moc = project.managedObjectContext!
        
        fetchedResultsController = NSFetchedResultsController<Task>(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error:", error)
        }
    }
}

extension ProjectDetailTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
