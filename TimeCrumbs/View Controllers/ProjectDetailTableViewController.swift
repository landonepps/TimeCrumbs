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
    
    // MARK: - Properties
    
    var project: Project?
    var fetchedResultsController: NSFetchedResultsController<Task>?
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var chargeRateLabel: UILabel!
    
    @IBOutlet weak var timeCrumbsView: UIView!
    @IBOutlet weak var timeCrumbsTotalLabel: UILabel!
    @IBOutlet weak var totalHoursLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        updateViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
            tableView.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        exportToCSV()
    }
    
    // MARK: - Table View Data Source
    
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let task = fetchedResultsController?.object(at: indexPath) {
                TaskController.deleteTask(task)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditProject" {
            guard let destination = segue.destination as? AddProjectViewController,
                let project = project
            else { return }
            
            destination.project = project
            
        } else if segue.identifier == "CellToLogTime" {
            guard let destination = segue.destination as? LogTimeViewController,
                let indexPath = tableView.indexPathForSelectedRow,
                let task = fetchedResultsController?.object(at: indexPath)
            else { return }
            
            destination.task = task
            destination.project = task.project
        }
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let project = project else { return }
        
        if let projectColorName = project.color,
            let projectColor = UIColor(named: projectColorName) {
            projectColorView.backgroundColor = projectColor
        }
        
        projectNameLabel.text = project.name
        clientNameLabel.text = project.clientName
        chargeRateLabel.text = "\(project.rate?.asCurrency() ?? "")" + (project.isHourly ? "/h" : " fixed")
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.predicate = NSPredicate(format: "project == %@", project)
        
        guard let tasks = try? project.managedObjectContext?.fetch(request) else { return }
        
        var totalTime = 0.0
        var totalIncome: NSDecimalNumber = 0.0
        var timeCrumbsTotal: NSDecimalNumber = 0.0
        
        for task in tasks {
            let duration = task.duration
            totalTime += duration
            
            if project.isHourly, let rate = project.rate {
                let taskIncome = rate.multiplying(by: NSDecimalNumber(value: duration)).dividing(by: 3600)
                totalIncome = totalIncome.adding(taskIncome)
                
                if duration <= 1800 {
                    timeCrumbsTotal = timeCrumbsTotal.adding(taskIncome)
                }
            }
        }
        
        if project.isHourly {
            timeCrumbsTotalLabel.text = timeCrumbsTotal.asCurrency()
            totalIncomeLabel.text = totalIncome.asCurrency()
        } else {
            timeCrumbsView.isHidden = true
            totalIncomeLabel.text = project.rate?.asCurrency()
        }
        totalHoursLabel.text = format(duration: totalTime)
    }
    
    func setupFetchedResultsController() {
        guard let project = project else { return }
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
    
    func exportToCSV() {
        var fileNameComponents = [String]()
        
        if let projectName = project?.name?.trimmingCharacters(in: .whitespacesAndNewlines) {
            fileNameComponents.append(projectName)
        }
        fileNameComponents.append("Tasks")
        
        let fileName = "\(fileNameComponents.joined(separator: " ")).csv"
        
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
    }
    
    func format(duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        
        return formatter.string(from: duration)!
    }
}

extension ProjectDetailTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
