//
//  Project.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

final class Project: NSManagedObject {
    @NSManaged fileprivate(set) var name: String
    @NSManaged fileprivate(set) var hourlyRate: Double
    @NSManaged fileprivate(set) var clientName: String
    @NSManaged fileprivate(set) var dateAdded: Date
    @NSManaged fileprivate(set) var archived: Bool
    @NSManaged fileprivate(set) var tasks: Set<Task>
}

extension Project: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(dateAdded), ascending: false)]
    }
}
