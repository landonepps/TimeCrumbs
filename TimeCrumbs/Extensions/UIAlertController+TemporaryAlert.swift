//
//  UIAlertController+TemporaryAlert.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/8/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func presentTemporaryAlert(in vc: UIViewController, title: String = "", message: String = "", duration: Double = 2) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        vc.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alertController.dismiss(animated: true)
        }
    }
}
