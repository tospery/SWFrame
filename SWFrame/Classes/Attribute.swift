//
//  Attribute.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit

public var pixelOne: CGFloat { QMUIHelper.pixelOne() }

public var isPad: Bool { QMUIHelper.isIPad() }
public var isPod: Bool { QMUIHelper.isIPod() }
public var isPhone: Bool { QMUIHelper.isIPhone() }
public var isSimulator: Bool { QMUIHelper.isSimulator() }

public var isNotchedScreen: Bool { QMUIHelper.isNotchedScreen() }
public var is65InchScreen: Bool { QMUIHelper.is65InchScreen() }
public var is61InchScreen: Bool { QMUIHelper.is61InchScreen() }
public var is58InchScreen: Bool { QMUIHelper.is58InchScreen() }
public var is55InchScreen: Bool { QMUIHelper.is55InchScreen() }
public var is47InchScreen: Bool { QMUIHelper.is47InchScreen() }
public var is40InchScreen: Bool { QMUIHelper.is40InchScreen() }
public var is35InchScreen: Bool { QMUIHelper.is35InchScreen() }
public var is320WidthScreen: Bool { (is40InchScreen || is35InchScreen) }

public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

public var iosVersion: Double { (UIDevice.current.systemVersion as NSString).doubleValue }
public var iosVersionNumber: Int { QMUIHelper.numbericOSVersion() }

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

public var safeArea: UIEdgeInsets { QMUIHelper.safeAreaInsetsForDeviceWithNotch() }
public var safeBottom: CGFloat { QMUIHelper.safeAreaInsetsForDeviceWithNotch().bottom }

public var screenWidth: CGFloat { UIScreen.width }
public var screenHeight: CGFloat { UIScreen.height }


