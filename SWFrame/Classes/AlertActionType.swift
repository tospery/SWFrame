//
//  AlertActionType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/21.
//

import UIKit
import RxSwift
import RxCocoa

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
        case (.default, .default), (.cancel, .cancel), (.destructive, .destructive):
            return true
        default:
            return false
        }
    }
}
