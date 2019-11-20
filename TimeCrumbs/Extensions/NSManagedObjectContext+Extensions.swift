//
//  NSManagedObjectContext+Extensions.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/20/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    @discardableResult
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return true
        }
    }
    
}
