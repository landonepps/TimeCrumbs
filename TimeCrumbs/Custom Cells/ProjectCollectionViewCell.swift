//
//  ProjectCollectionViewCell.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

protocol ProjectCollectionViewCellDelegate {
    func logTimeButtonTapped(cell: ProjectCollectionViewCell)
    func startButtonTapped(cell: ProjectCollectionViewCell)
}

class ProjectCollectionViewCell: UICollectionViewCell, ExpandableCell {
    
    var delegate: ProjectCollectionViewCellDelegate?
    var project: Project? {
        didSet {
            setupViews()
        }
    }
    
    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectColorView: UIView!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var logTimeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logTimeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutViews()
    }
    
    // MARK: - Actions
    
    @IBAction func logTimeButtonTapped(_ sender: UIButton) {
        delegate?.logTimeButtonTapped(cell: self)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        delegate?.startButtonTapped(cell: self)
    }
    
    // MARK: - Helpers

    private func layoutViews() {
        // Cell color
        backgroundColor = .clear
        contentView.backgroundColor = UIColor(named: "cellColor")
        
        // Rounded corners
        let cornerRadius = 24
        let path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.frame = contentView.bounds
        mask.path = path.cgPath
        contentView.layer.mask = mask
        contentView.layer.masksToBounds = true
        
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
        layer.shadowPath = path.cgPath

        // Button image color
        logTimeButton.imageView?.tintColor = UIColor.white
        startButton.imageView?.tintColor = UIColor.white
    }
    
    private func setupViews() {
        projectLabel.text = project?.name
        if let projectColorName = project?.color,
            let projectColor = UIColor(named: projectColorName)
        {
            projectColorView.backgroundColor = projectColor
            logTimeButton.tintColor = projectColor
            startButton.tintColor = projectColor
        }
        
    }
    
    // MARK: - Expanding/Collapsing
    
    func expand(in collectionView: UICollectionView) {
        initialFrame = frame
        
        frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        
        layoutIfNeeded()
    }
    
    func collapse() {
        frame = initialFrame ?? frame
        
        initialFrame = nil
        
        layoutIfNeeded()
    }
    
}
