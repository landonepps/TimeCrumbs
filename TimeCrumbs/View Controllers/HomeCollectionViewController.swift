//
//  HomeCollectionViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import CoreData

fileprivate let reuseIdentifier = "ProjectCell"

class HomeCollectionViewController: UICollectionViewController {
    
    // Set by the SceneDelegate's scene(scene:willConnectTo:options:) method
    var moc: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController<Project>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(ProjectCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UINib(nibName: "ProjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        fetchedResultsController = NSFetchedResultsController<Project>(fetchRequest: Project.sortedFetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error:", error)
        }
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
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProjectCollectionViewCell else { fatalError("Incorrect cell type: expected ProjectCollectionViewCell") }
    
        // Configure the cell
    
        return cell
    } 

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "CellToProjectDetail", sender: cell)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}

extension HomeCollectionViewController: CoreDataClient {
    func set(moc: NSManagedObjectContext) {
        self.moc = moc
    }
}
