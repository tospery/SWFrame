//
//  UIScreen+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

public extension UIScreen {
    
    enum Kind {
        case small
        case middle
        case large
    }

    private static var kindValue: Kind?
    static var kind: Kind {
        if UIScreen.kindValue != nil {
            return UIScreen.kindValue!
        }
        let width = min(self.width, self.height)
        if width <= 320 {
            UIScreen.kindValue = .small
        } else if width > 320 && width < 414 {
            UIScreen.kindValue = .middle
        } else {
            UIScreen.kindValue = .large
        }
        return UIScreen.kindValue!
    }
    
    /// 320
    ///
    ///     320x480(0.67)         4
    ///     320x568         5/5s
    static var isSmall: Bool {
        self.kind == .small
    }

    /// 360 | 375 | 390
    ///
    ///     360x780         12mini
    ///     375x667         6/6s
    ///     375x812         X/Xs/11Pro
    ///     390x844         12/12Pro
    static var isMiddle: Bool {
        self.kind == .middle
    }
    
    /// 414 | 428
    ///
    ///     414x736         6Plus
    ///     414x896         Xr/XsMax/11/11ProMax
    ///     428x926(0.46)         12ProMax
    static var isLarge: Bool {
        self.kind == .large
    }
    
    static var isNotched: Bool {
        QMUIHelper.isNotchedScreen
    }
    
    static var isRegular: Bool {
        QMUIHelper.isRegularScreen
    }
    
    static var width: CGFloat {
        self.main.bounds.size.width
    }
    
    static var height: CGFloat {
        self.main.bounds.size.height
    }
    
    static var rawHeight: CGFloat {
        self.height - UINavigationBar.contentHeightConstant - self.safeBottom
    }
    
    static var minEdge: CGFloat {
        self.main.bounds.minEdge
    }
    
    static var maxEdge: CGFloat {
        self.main.bounds.maxEdge
    }
    
    static var statusBarHeight: CGFloat {
        SWHelper.sharedInstance().statusBarHeight
    }
    
    static var statusBarHeightConstant: CGFloat {
        SWHelper.sharedInstance().statusBarHeightConstant
    }
    
    static var safeArea: UIEdgeInsets {
        QMUIHelper.safeAreaInsetsForDeviceWithNotch
    }
    
    static var safeBottom: CGFloat {
        self.safeArea.bottom
    }
    
}
