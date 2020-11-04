//
//  EnumExt.swift
//  SWFrame
//
//  Created by liaoya on 2020/7/9.
//

import UIKit

public extension UIStatusBarStyle {

    var reversed: UIStatusBarStyle {
        switch self {
        case .lightContent:
            return .default
        default:
            return .lightContent
        }
    }

}
