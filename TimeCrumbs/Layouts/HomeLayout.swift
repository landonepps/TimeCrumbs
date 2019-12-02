//
//  HomeLayout.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

struct HomeLayoutConstants {
    let collapsedHeight = 140
    #warning("This will be based on the screen size")
    let expandedHeight = 300
}

class HomeLayout: UICollectionViewLayout {
    
    // MARK: - UICollectionViewLayout
    
    override func prepare() {
        // Set up layout for initial state
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        if indexPath == collectionView?.indexPathsForSelectedItems?.first {
            
        } else {
            
        }
        
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        #warning("Placeholder")
        return CGSize()
    }
    
    // Return the content offset of the nearest cell to have snapping
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        #warning("Placeholder")
        return CGPoint()
    }
    
    // Whenever
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        #warning("Placeholder")
        return true
    }
}
