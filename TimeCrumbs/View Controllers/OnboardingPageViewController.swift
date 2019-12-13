//
//  OnboardingPageViewController.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/11/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.instantiateViewController(named: "PageOne"),
                self.instantiateViewController(named: "PageTwo"),
                self.instantiateViewController(named: "PageThree"),
                self.instantiateViewController(named: "PageFour"),
                self.instantiateViewController(named: "PageFive")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func instantiateViewController(named name: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: name)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
            else { return nil }
        guard orderedViewControllers.count > previousIndex
            else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex
            else { return nil }
        guard orderedViewControllers.count > nextIndex
            else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
}
