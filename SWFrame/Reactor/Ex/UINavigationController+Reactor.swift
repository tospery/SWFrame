//
//  UINavigationControllerExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/15.
//

import UIKit

public extension UINavigationController {
    
    var rootViewController: UIViewController? {
        self.viewControllers.first
    }
    
}
