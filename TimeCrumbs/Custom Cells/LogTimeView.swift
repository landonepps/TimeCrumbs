//
//  LogTimeView.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/3/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class LogTimeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var addCategoryTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: LogTimeView.self), owner: nil, options: nil)
    }
}
