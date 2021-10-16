//
//  Constant.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit

// MARK: - 变量-编译相关
/// 判断当前是否debug编译模式
public var isDebug: Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}

// MARK: - 变量-设备相关
// MARK: 设备类型
public var isPad: Bool { SWHelper.isIPad }
public var isPod: Bool { SWHelper.isIPod }
public var isPhone: Bool { SWHelper.isIPhone }
public var isSimulator: Bool { SWHelper.isSimulator }

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
public var osVersion: Double { (UIDevice.current.systemVersion as NSString).doubleValue }
/// 数字形式的操作系统版本号，可直接用于大小比较；如 110205 代表 11.2.5 版本；根据 iOS 规范，版本号最多可能有3位
public var osVersionNumber: Int { SWHelper.numbericOSVersion() }

/// 是否横竖屏，用户界面横屏了才会返回YES
public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
/// 是否横竖屏，无论支不支持横屏，只要设备横屏了，就会返回YES
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

/// 横边宽度，会根据横竖屏的变化而变化
public var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
/// 竖边高度，会根据横竖屏的变化而变化
public var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
/// 屏幕宽度，跟横竖屏无关
public var deviceWidth: CGFloat { min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
/// 屏幕高度，跟横竖屏无关
public var deviceHeight: CGFloat { max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
/// 在 iPad 分屏模式下等于 app 实际运行宽度，否则等同于 SCREEN_WIDTH
public var applicationWidth: CGFloat { SWHelper.applicationSize.width }
/// 在 iPad 分屏模式下等于 app 实际运行宽度，否则等同于 DEVICE_HEIGHT
public var applicationHeight: CGFloat { SWHelper.applicationSize.height }

/// 是否全面屏设备
public var isNotchedScreen: Bool { SWHelper.isNotchedScreen }
/// 将屏幕分为普通和紧凑两种，这个方法用于判断普通屏幕（也即大屏幕）。
public var isRegularScreen: Bool { SWHelper.isRegularScreen }
/// 紧凑屏幕，即小屏幕
public var isCompactScreen: Bool { !SWHelper.isRegularScreen }

public var isSmallScreen: Bool { screenWidth <= 320 }
public var isMiddleScreen: Bool { screenWidth > 320 && screenWidth < 414 }
public var isLargeScreen: Bool { screenWidth >= 414 }

/// iPhoneX 系列全面屏手机的安全区域的静态值
public var safeArea: UIEdgeInsets { SWHelper.safeAreaInsetsForDeviceWithNotch }
/// 底部高度
public var safeBottom: CGFloat { safeArea.bottom }

/// bounds && nativeBounds / scale && nativeScale
public var screenBoundsSize: CGSize { UIScreen.main.bounds.size }
public var screenNativeBoundsSize: CGSize { UIScreen.main.nativeBounds.size }
public var screenScale: CGFloat { UIScreen.main.scale }
public var screenNativeScale: CGFloat { UIScreen.main.nativeScale }

/// toolBar相关frame
public var toolBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 70 : (osVersion >= 12.0 ? 50 : 44)) : (isLandscape ? preferredValue(regular: 44, compact: 32) : 44) + safeBottom)
}
/// tabBar相关frame
public var tabBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 65 : (osVersion >= 12.0 ? 50 : 49)) : (isLandscape ? preferredValue(regular: 49, compact: 32) : 49) + safeBottom)
}
/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
public var statusBarHeight: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height)
}
/// 状态栏高度(如果状态栏不可见，也会返回一个普通状态下可见的高度)
public var statusBarHeightConstant: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? (isPad ? (isNotchedScreen ? 24 : 20) : preferredValue(notched: isLandscape ? 0 : (SWHelper.deviceModel == "iPhone12,1" ? 48 : (SWHelper.is61InchScreenAndiPhone12 || SWHelper.is61InchScreen ? 47 : 44)) , other: 20)) : UIApplication.shared.statusBarFrame.size.height)
}
/// navigationBar 的静态高度
public var navigationBarHeight: CGFloat {
    (isPad ? (osVersion >= 12.0 ? 50 : 44) : (isLandscape ? preferredValue(regular: 44, compact: 32) : 44))
}
/// 代表(导航栏+状态栏)，这里用于获取其高度
/// @warn 如果是用于 viewController，请使用 UIViewController(QMUI) qmui_navigationBarMaxYInViewCoordinator 代替
public var navigationContentTop: CGFloat {
    (statusBarHeight + navigationBarHeight)
}
/// 同上，这里用于获取它的静态常量值
public var navigationContentTopConstant: CGFloat {
    (statusBarHeightConstant + navigationBarHeight)
}

/// 判断当前是否是处于分屏模式的 iPad
public var isSplitScreenIPad: Bool {
    (isPad && applicationWidth != screenWidth)
}

public var pixelOne: CGFloat { SWHelper.pixelOne }


public typealias KVTuple = (key: Any, value: Any?)
public var dateTimeFormatStyle1: String { "yyyy/MM/dd HH:mm:ss" }
