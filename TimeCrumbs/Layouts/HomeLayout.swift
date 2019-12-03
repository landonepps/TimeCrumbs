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
        self.itemSize = CGSize(width: width - 10, height: HomeLayoutConstants.collapsedHeight)
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

//    override var collectionViewContentSize: CGSize {
//        #warning("Placeholder")
//        return  collectionView!.frame.size
//    }
    
    // Return the content offset of the nearest cell to have snapping
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        #warning("Placeholder")
//        return CGPoint()
//    }
    
    // Whenever
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        #warning("Placeholder")
        return true
    }
}
