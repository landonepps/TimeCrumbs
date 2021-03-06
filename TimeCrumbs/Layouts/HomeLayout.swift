//
//  HomeLayout.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

struct HomeLayoutConstants {
    static let collapsedHeight: CGFloat = 140
}

class HomeLayout: UICollectionViewFlowLayout {
    
    // MARK: - UICollectionViewLayout
    
    override func prepare() {
        super.prepare()
        // Set up layout for initial state
        
        let width = collectionView!.bounds.width
        itemSize = CGSize(width: width - 16, height: HomeLayoutConstants.collapsedHeight)
        sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
        minimumLineSpacing = 24.0
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

        if indexPath == collectionView?.indexPathsForSelectedItems?.first {

        } else {

        }

        let width = collectionView!.bounds.width
        attributes.size = CGSize(width: width - 10, height: HomeLayoutConstants.collapsedHeight)

        return attributes
    }

}
