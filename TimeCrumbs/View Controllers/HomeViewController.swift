//
//  HomeViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

fileprivate let reuseIdentifier = "ProjectCell"

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController<Project>?
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addAProjectLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProjectCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "ProjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(named: "backgroundColor")

        fetchedResultsController = NSFetchedResultsController<Project>(fetchRequest: Project.sortedFetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error:", error)
        }
        
        updateViews()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellToProjectDetail" {
            guard let cell = sender as? ProjectCollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell),
                let destination = segue.destination as? ProjectDetailTableViewController,
                let project = fetchedResultsController?.object(at: indexPath)
            else { return }
            
            destination.project = project

        } else if segue.identifier == "CellToLogTime" {
            guard let cell = sender as? ProjectCollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell),
                let destination = segue.destination as? LogTimeViewController,
                let project = fetchedResultsController?.object(at: indexPath)
                else { return }
            
            destination.project = project
            
        } else if segue.identifier == "CellToTimer" {
            guard let cell = sender as? ProjectCollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell),
                let destination = segue.destination as? TimerViewController,
                let project = fetchedResultsController?.object(at: indexPath)
                else { return }
            
            destination.project = project
            
        } else if segue.identifier == "AddProject" {
            guard let destination = segue.destination as? AddProjectViewController
                else { return }
            
            destination.moc = moc
        }
    }
    
    // MARK: - Helper Methods
    
    func updateViews() {
       addAProjectLabel.isHidden = (fetchedResultsController?.fetchedObjects?.count ?? 0) > 0
    }
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProjectCollectionViewCell,
            let project = fetchedResultsController?.object(at: indexPath)
        else { fatalError("Incorrect cell type: expected ProjectCollectionViewCell") }
        
        cell.delegate = self
        cell.project = project
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "CellToProjectDetail", sender: cell)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: ProjectCollectionViewCellDelegate {
    func logTimeButtonTapped(cell: ProjectCollectionViewCell) {
        performSegue(withIdentifier: "CellToLogTime", sender: cell)
    }
    
    func startButtonTapped(cell: ProjectCollectionViewCell) {
        performSegue(withIdentifier: "CellToTimer", sender: cell)
    }
}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
        updateViews()
    }
}

extension HomeViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
