//
//  TaskController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // MARK: - CRUD
    // Create
    static func createTask(project: Project, name: String, startTime: Date? = nil, duration: Double = 0, date: Date = Date(), moc: NSManagedObjectContext) {
        let task = Task(context: moc)
        
        task.project = project
        task.name = name
        task.startTime = startTime
        task.duration = duration
        task.date = date
        moc.saveOrRollback()
    }
    
    // Update
    static func updateTask(_ task: Task, name: String, date: Date, duration: Double) {
        task.name = name
        task.date = date
        task.duration = duration
        
        task.managedObjectContext?.saveOrRollback()
    }
    
    static func pauseTask(_ task: Task) {
        guard let startTime = task.startTime else {return}
        
        task.duration = Date().timeIntervalSince(startTime)
        task.startTime = nil
        task.managedObjectContext?.saveOrRollback()
    }
    
    static func resumeTask(_ task: Task) {
        guard task.startTime == nil else {return}
        
        task.startTime = Date()
        task.managedObjectContext?.saveOrRollback()
    }
    
    static func finishTask(_ task: Task) {
        guard let startTime = task.startTime else {return}
        
        task.duration = Date().timeIntervalSince(startTime)
        task.managedObjectContext?.saveOrRollback()
    }
    
    // Delete
    static func cancelTask(_ task: Task) {
        task.startTime = nil
        task.managedObjectContext?.saveOrRollback()
    }
    
    static func deleteTask(_ task: Task) {
        let moc = task.managedObjectContext
        
        moc?.delete(task)
        moc?.saveOrRollback()
    }
}
