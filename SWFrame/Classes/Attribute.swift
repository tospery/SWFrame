//
//  Attribute.swift
//  SWFrame
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
public var isSmallWidthScreen: Bool { UIScreen.width <= 320 }
public var isMiddleWidthScreen: Bool { UIScreen.width > 320 && UIScreen.width < 414 }
public var isLargeWidthScreen: Bool { UIScreen.width >= 414 }

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


