//
//  Task.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

final class Task: NSManagedObject {
    @NSManaged var startTime: Date?
    @NSManaged var duration: Double
    @NSManaged var date: Date
    @NSManaged var category: Category?
    @NSManaged var project: Project
}
