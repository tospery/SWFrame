//
//  Constant.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/11.
//

import UIKit
import QMUIKit

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
/// 设备类型
public var isPad: Bool { QMUIHelper.isIPad }
public var isPod: Bool { QMUIHelper.isIPod }
public var isPhone: Bool { QMUIHelper.isIPhone }
public var isSimulator: Bool { QMUIHelper.isSimulator }

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
public var iOSVersion: Double { (UIDevice.current.systemVersion as NSString).doubleValue }

/// 是否横竖屏
/// 用户界面横屏了才会返回YES
public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
/// 无论支不支持横屏，只要设备横屏了，就会返回YES
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

/// 屏幕宽度，会根据横竖屏的变化而变化
public var screenWidth: CGFloat { UIScreen.main.bounds.size.width }

/// 屏幕高度，会根据横竖屏的变化而变化
public var screenHeight: CGFloat { UIScreen.main.bounds.size.height }

/// 设备宽度，跟横竖屏无关
public var deviceWidth: CGFloat { min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }

/// 设备高度，跟横竖屏无关
public var deviceHeight: CGFloat { max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }

/// 是否全面屏设备
public var isNotchedScreen: Bool { QMUIHelper.isNotchedScreen }

/// 将屏幕分为普通和紧凑两种，这个方法用于判断普通屏幕（也即大屏幕）。
/// @note 注意，这里普通/紧凑的标准是 SWFrame 自行制定的，与系统 UITraitCollection.horizontalSizeClass/verticalSizeClass 的值无关。只要是通常意义上的“大屏幕手机”（例如 Plus 系列）都会被视为 Regular Screen。
public var isRegularScreen: Bool { QMUIHelper.isRegularScreen }

/// 是否Retina
public var isRetinaScreen: Bool { UIScreen.main.scale >= 2.0 }

/// SWFrame自定义的iPhone屏幕大小分类，以设备宽度为基准。
public var isSmallScreen: Bool { deviceWidth <= 320 }
public var isMiddleScreen: Bool { deviceWidth > 320 && deviceWidth < 414 }
public var isLargeScreen: Bool { deviceWidth >= 414 }

/// 是否放大模式（iPhone 6及以上的设备支持放大模式，iPhone X 除外）
public var isZoomMode: Bool { QMUIHelper.isZoomedMode }

// MARK: - 变量-布局相关
/// 获取一个像素
public var pixelOne: CGFloat { QMUIHelper.pixelOne }

/// bounds && nativeBounds / scale && nativeScale
public var screenBoundsSize: CGSize { UIScreen.main.bounds.size }
public var screenNativeBoundsSize: CGSize { UIScreen.main.nativeBounds.size }
public var screenScale: CGFloat { UIScreen.main.scale }
public var screenNativeScale: CGFloat { UIScreen.main.nativeScale }

public var toolBarHeight: CGFloat { SWHelper.sharedInstance().toolBarHeight }
public var tabBarHeight: CGFloat { SWHelper.sharedInstance().tabBarHeight }
public var statusBarHeight: CGFloat { SWHelper.sharedInstance().statusBarHeight }
public var statusBarHeightConstant: CGFloat { SWHelper.sharedInstance().statusBarHeightConstant }
public var navigationBarHeight: CGFloat { SWHelper.sharedInstance().navigationBarHeight }
public var navigationContentTop: CGFloat { SWHelper.sharedInstance().navigationContentTop }
public var navigationContentTopConstant: CGFloat { SWHelper.sharedInstance().navigationContentTopConstant }

public var safeArea: UIEdgeInsets { QMUIHelper.safeAreaInsetsForDeviceWithNotch }

// MARK: - Other
public typealias KVTuple = (key: Any, value: Any?)
public typealias SectionData = (header: ModelType?, items: [ModelType])

public var dateTimeFormatStyle1: String { "yyyy/MM/dd HH:mm:ss" }
