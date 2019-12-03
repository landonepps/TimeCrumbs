//
//  ProjectControllers.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/25/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

class ProjectController {
    
    // MARK: - CRUD
    // Create
    static func createProject(name: String, hourlyRate: Double = 0, clientName: String = "", dateAdded: Date = Date(), color: String, moc: NSManagedObjectContext) {
        let project = Project(context: moc)
        
        project.name = name
        project.hourlyRate = hourlyRate
        project.clientName = clientName
        project.dateAdded = dateAdded
        project.color = color
        project.isArchived = false
        
        moc.saveOrRollback()
    }
    
    // Update
    static func updateProject(_ project: Project, name: String, hourlyRate: Double, clientName: String, color: String) {
        project.name = name
        project.hourlyRate = hourlyRate
        project.clientName = clientName
        project.color = color
        
        project.managedObjectContext?.saveOrRollback()
    }
    
    // Delete
    static func deleteProject(_ project: Project) {
        let moc = project.managedObjectContext
        
        moc?.delete(project)
        moc?.saveOrRollback()
    }
    
    // Archive
    static func archiveProject(_ project: Project) {
        project.isArchived = true
        
        project.managedObjectContext?.saveOrRollback()
    }
    
    static func unarchiveProject(_ project: Project) {
        project.isArchived = false
        
        project.managedObjectContext?.saveOrRollback()
    }
}
