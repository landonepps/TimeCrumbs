//
//  PrivacyPolicyViewController.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var privacyPolicyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let text = privacyPolicyTextView.attributedText.mutableCopy() as? NSMutableAttributedString {
            text.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: text.mutableString.length))
            
            privacyPolicyTextView.attributedText = text
        }
    }

}
