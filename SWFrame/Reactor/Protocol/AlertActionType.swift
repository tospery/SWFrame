//
//  AlertActionType.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

// YJX_TODO
// 1. Border/SWButton修改为swift版本
// 2. 扩展修改为Ex+Rx两种命名方式
// 3. 本地字符串 -> Strings.swift
// 4. Generated duplicate UUIDs:
//[!] Your project does not explicitly specify the CocoaPods master specs repo. Since CDN is now used as the default, you may safely remove it from your repos directory via `pod repo remove master`. To suppress this warning please add `warn_for_unused_master_specs_repo => false` to your Podfile.

import UIKit

public protocol AlertActionType {
    var title: String? { get }
    var style: UIAlertAction.Style { get }
}

extension AlertActionType {
    var style: UIAlertAction.Style {
        return .default
    }
}

public enum SimpleAlertAction: AlertActionType, Equatable {
    case `default`
    case cancel
    case destructive
    
    public var title: String? {
        switch self {
        case .default:      return NSLocalizedString("OK", comment: "")
        case .cancel:       return NSLocalizedString("Cancel", comment: "")
        case .destructive:  return NSLocalizedString("Sure", comment: "")
        }
    }
    
    public var style: UIAlertAction.Style {
        switch self {
        case .default:      return .default
        case .cancel:       return .cancel
        case .destructive:  return .destructive
        }
    }
    
    public static func ==(lhs: SimpleAlertAction, rhs: SimpleAlertAction) -> Bool {
        switch (lhs, rhs) {
        case (.default, .default),
            (.cancel, .cancel),
            (.destructive, .destructive):
            return true
        default:
            return false
        }
    }
}
