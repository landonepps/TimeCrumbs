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
    @NSManaged fileprivate(set) var startTime: Date?
    @NSManaged fileprivate(set) var duration: Double
    @NSManaged fileprivate(set) var date: Date
    @NSManaged fileprivate(set) var category: Category?
    @NSManaged fileprivate(set) var project: Project
}
