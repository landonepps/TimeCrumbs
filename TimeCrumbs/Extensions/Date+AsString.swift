//
//  Date+AsString.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter.string(from: self)
    }
}
