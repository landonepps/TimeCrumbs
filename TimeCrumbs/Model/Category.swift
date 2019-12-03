//
//  Category.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject, Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: false)]
    }
    
}
