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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        exportToCSV()
    }

    // MARK: - Table View Data Source
    
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if let task = fetchedResultsController?.object(at: indexPath) {
            if task.isActive {
                return .none
            }
        }
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let task = fetchedResultsController?.object(at: indexPath) {
                let alertController = UIAlertController(title: "Delete", message: "Delete the task?", preferredStyle: .alert)
                let goBackAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
                let finishAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                    TaskController.deleteTask(task)
                }
                alertController.addAction(goBackAction)
                alertController.addAction(finishAction)
                present(alertController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let task = fetchedResultsController?.object(at: indexPath) else { return nil }

        if task.isActive {
            return nil
        }

        return indexPath
    }

    // MARK: - Navigation

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
        let fileName = "Tasks.csv"
        var path: URL
        do {
            let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                            isDirectory: true)
            path = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
            try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            path = path.appendingPathComponent(fileName)
        } catch {
            print(error)
            return
        }
        
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
