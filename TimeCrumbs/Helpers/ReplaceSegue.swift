//
//  ReplaceSegue.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ReplaceSegue: UIStoryboardSegue {
    override func perform() {
        var viewControllers = source.navigationController?.viewControllers ?? []
        _ = viewControllers.popLast()
        viewControllers.append(destination)
        source.navigationController?.setViewControllers(viewControllers, animated: true)
    }
}
