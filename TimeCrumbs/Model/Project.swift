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
    @NSManaged var name: String
    @NSManaged var hourlyRate: Double
    @NSManaged var clientName: String
    @NSManaged var dateAdded: Date
    @NSManaged var archived: Bool
    @NSManaged var tasks: Set<Task>
}

extension Project: Managed {
    
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(dateAdded), ascending: false)]
    }
}
