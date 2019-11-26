//
//  CoreDataClient.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 11/26/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import CoreData

protocol CoreDataClient {
    func set(moc: NSManagedObjectContext)
}
