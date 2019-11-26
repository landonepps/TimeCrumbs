//
//  Category.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

final class Category: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var tasks: Set<Task>
}
