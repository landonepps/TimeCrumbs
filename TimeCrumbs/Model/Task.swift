//
//  Task.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject, Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
    
}
