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
    
    // MARK: - Outlets
    @IBOutlet weak var dateRangeButton: UIButton!
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<Task>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = NSFetchedResultsController<Task>(fetchRequest: Task.sortedFetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error:", error)
        }
    }
    
    // MARK: - Actions
    @IBAction func dateRangeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        exportToCSV()
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? LogItemTableViewCell
            else { fatalError("Cell with identifier TaskCell is not of type LogItemTableViewCell")}
        
        if let task = fetchedResultsController?.object(at: indexPath) {
            cell.update(with: task)
        }
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLogTimeVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let task = fetchedResultsController?.object(at: indexPath),
                let destination = segue.destination as? LogTimeViewController
                else { return }
            
            destination.task = task
            destination.project = task.project
        }
    }
    
    // MARK: - Helpers
    
    func exportToCSV() {
        let fileName = "tasks.csv"
        let path = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        var csvText = "date,project,client,task,duration,amount\n"
        
        for task in fetchedResultsController?.fetchedObjects ?? [] {
            var taskLine = [String]()
            taskLine.append("\(task.date?.asString() ?? "")")
            taskLine.append("\(task.project?.name ?? "")")
            taskLine.append("\(task.project?.clientName ?? "")")
            taskLine.append("\(task.name ?? "")")
            taskLine.append("\(task.duration / 60)")
            
            if task.project?.isHourly ?? false,
                let rate = task.project?.rate
                {
                    taskLine.append("\(rate.multiplying(by: NSDecimalNumber(floatLiteral: task.duration)).dividing(by: 3600))")
            } else {
                taskLine.append("")
            }
            csvText.append("\(taskLine.joined(separator: ","))\n")
        }
        
        do {
            try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
            
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        } catch {
            print("Failed to create file", error)
        }
        // Present Alert Controller?
    }
}


extension LogTableViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}

extension LogTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
