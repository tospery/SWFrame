//
//  Attribute.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

// YJX_TODO
public var pixelOne: CGFloat { 1 /*QMUIHelper.pixelOne*/ }

public var isPad: Bool { UIDevice.current.kind == .ipad }
public var isPod: Bool { UIDevice.current.kind == .ipod }
public var isPhone: Bool { UIDevice.current.kind == .iphone }
public var isSimulator: Bool { UIDevice.current.kind == .simulator }

public var isNotchedScreen: Bool { false /*QMUIHelper.isNotchedScreen*/ }

/// 320
///
///     320x480         4
///     320x568         5/5s
public var isSmallWidthScreen: Bool { UIScreen.width <= 320 }

/// 360 | 375 | 390
///
///     360x780         12mini
///     375x667         6/6s
///     375x812         X/Xs/11Pro
///     390x844         12/12Pro
public var isMiddleWidthScreen: Bool { UIScreen.width > 320 && UIScreen.width < 414 }

/// 414 | 428
///
///     414x736         6Plus
///     414x896         Xr/XsMax/11/11ProMax
///     428x926         12ProMax
public var isLargeWidthScreen: Bool { UIScreen.width >= 414 }

public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

public var iosVersion: Double { (UIDevice.current.systemVersion as NSString).doubleValue }
public var iosVersionNumber: Int { 1 /*QMUIHelper.numbericOSVersion()*/ } // YJX_TODO

public var statusBarHeight: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height)
}
public var statusBarHeightConstant: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? (isPad ? (isNotchedScreen ? 24 : 20) : alternate(notched: (isLandscape ? 0 : 44), other: 20)) : UIApplication.shared.statusBarFrame.size.height)
}
public var navigationBarHeight: CGFloat {
    (isPad ? (iosVersion >= 12.0 ? 50 : 44) : (isLandscape ? alternate(regular: 44, compact: 32) : 44))
}
public var navigationContentTop: CGFloat {
    (statusBarHeight + navigationBarHeight)
}
public var navigationContentTopConstant: CGFloat {
    (statusBarHeightConstant + navigationBarHeight)
}
public var tabBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 65 : (iosVersion >= 12.0 ? 50 : 49)) : (isLandscape ? alternate(regular: 49, compact: 32) : 49) + safeBottom)
}
public var toolBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 70 : (iosVersion >= 12.0 ? 50 : 44)) : (isLandscape ? alternate(regular: 44, compact: 32) : 44) + safeBottom)
}

// YJX_TODO
public var safeArea: UIEdgeInsets { .zero/*QMUIHelper.safeAreaInsetsForDeviceWithNotch*/ }
public var safeBottom: CGFloat { 1/*QMUIHelper.safeAreaInsetsForDeviceWithNotch.bottom*/ }

public var screenWidth: CGFloat { UIScreen.width }
public var screenHeight: CGFloat { UIScreen.height }


