//
//  CategoryController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

class CategoryController {
    
    // MARK: - CRUD
    // Create
    static func addNewCategory(name: String, moc: NSManagedObjectContext) {
        let category = Category(context: moc)
        category.name = name
        
        moc.saveOrRollback()
    }
    
    // Update
    static func updateCategory(_ category: Category, with name: String) {
        category.name = name
        
        category.managedObjectContext?.saveOrRollback()
    }
    
    // Delete
    static func deleteCategory(_ category: Category) {
        let moc = category.managedObjectContext
        moc?.delete(category)
        
        moc?.saveOrRollback()
    }
}
