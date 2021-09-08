//
//  EnumEx.swift
//  SWFrame
//
//  Created by liaoya on 2020/7/9.
//

import UIKit

public extension UIStatusBarStyle {

    var reversed: UIStatusBarStyle {
        switch self {
        case .default:
            if #available(iOS 12.0, *) {
                switch UIScreen.main.traitCollection.userInterfaceStyle {
                case .light:
                    if #available(iOS 13.0, *) {
                        return .darkContent
                    } else {
                        return .default
                    }
                default: return .lightContent
                }
            } else {
                return .lightContent
            }
        case .lightContent:
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .default
            }
        default:
            return .lightContent
        }
    }

}
