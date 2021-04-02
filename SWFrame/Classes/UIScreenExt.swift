//
//  UIScreenExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public extension UIScreen {
    
    enum Kind {
        case regular
        case notched
    }
    
    private static var kindValue: Kind?
    var kind: Kind {
        if UIScreen.kindValue != nil {
            return UIScreen.kindValue!
        }
        if QMUIHelper.isNotchedScreen {
            UIScreen.kindValue = .notched
        } else {
            UIScreen.kindValue = .regular
        }
        return UIScreen.kindValue!
    }
    
    var isRegular: Bool {
        self.kind == .regular
    }
    
    var isNotched: Bool {
        self.kind == .notched
    }
    
    /// 320|360|375|390|414|428
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}
