//
//  Decimal+AsCurrency.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/5/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
    
    func asCurrency() -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        
        return formatter.string(from: self)
    }
}
