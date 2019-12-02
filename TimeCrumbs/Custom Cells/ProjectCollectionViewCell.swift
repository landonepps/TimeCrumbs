//
//  ProjectCollectionViewCell.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logTimeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func logTimeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Methods
    
    func setupViews() {
        startButton.imageView?.tintColor = UIColor.white
    }
    
}
