//
//  TaskController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation

class TaskController {
    
    // MARK: - CRUD
    // Create
    func startTask(startTime: Date? = nil, duration: Double = 0, date: Date = Date()) {
        
    }
    
    // Update
    func pauseTask(task: Task) {
        // get duration
        // reset start time
        // save
    }
    
    func resumeTask(task: Task) {
        // set start time
        // save
    }
    
    func finishTask(task: Task) {
        // stop timer
        // set duration
    }
    
    func setCategory(task: Task, category: Category) {
        
    }
    
    // Delete
    func cancelTask(task: Task) {
        // reset start time to nil
    }
    
    func deleteTask(task: Task) {
        // delete task
    }
}
