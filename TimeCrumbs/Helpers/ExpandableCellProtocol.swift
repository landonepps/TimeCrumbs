//
//  ExpandableCellProtocol.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/4/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

protocol ExpandableCell {
    func expand(in: UICollectionView)
    func collapse()
}
