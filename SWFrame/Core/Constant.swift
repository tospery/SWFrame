//
//  Constant.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/11.
//

import UIKit
import DeviceKit

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
public var isPad: Bool { Device.current.isPad }
public var isPod: Bool { Device.current.isPod }
public var isPhone: Bool { Device.current.isPhone }
public var isSimulator: Bool { Device.current.isSimulator }

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

/// iPhone 12 Pro Max
public var is67InchScreen: Bool { Device.current.diagonal == 6.7 }
/// iPhone XS Max
public var is65InchScreen: Bool { Device.current.diagonal == 6.5 }
/// iPhone XR
public var is61InchScreen: Bool { Device.current.diagonal == 6.1 }
/// iPhone X/XS
public var is58InchScreen: Bool { Device.current.diagonal == 5.8 }
/// iPhone 6/7/8 Plus
public var is55InchScreen: Bool { Device.current.diagonal == 5.5 }
/// iPhone 12 mini
public var is54InchScreen: Bool { Device.current.diagonal == 5.4 }
/// iPhone 6/7/8
public var is47InchScreen: Bool { Device.current.diagonal == 4.7 }
/// iPhone 5/5S/SE
public var is40InchScreen: Bool { Device.current.diagonal == 4.0 }
/// iPhone 4/4S
public var is35InchScreen: Bool { Device.current.diagonal == 3.5 }

/// 是否全面屏设备
public var isNotchedScreen: Bool { Device.current.hasSensorHousing }

/// 将屏幕分为普通和紧凑两种，这个方法用于判断普通屏幕（也即大屏幕）。
/// @note 注意，这里普通/紧凑的标准是 SWFrame 自行制定的，与系统 UITraitCollection.horizontalSizeClass/verticalSizeClass 的值无关。只要是通常意义上的“大屏幕手机”（例如 Plus 系列）都会被视为 Regular Screen。
/// @NEW_DEVICE_CHECKER
public var isRegularScreen: Bool {
    isPad || (!isZoomMode && (is67InchScreen || is65InchScreen || is61InchScreen || is55InchScreen))
}

/// 是否Retina
public var isRetinaScreen: Bool { UIScreen.main.scale >= 2.0 }

/// SWFrame自定义的iPhone屏幕大小分类，以设备宽度为基准。
public var isSmallScreen: Bool { deviceWidth <= 320 }
public var isMiddleScreen: Bool { deviceWidth > 320 && deviceWidth < 414 }
public var isLargeScreen: Bool { deviceWidth >= 414 }

/// 是否放大模式（iPhone 6及以上的设备支持放大模式，iPhone X 除外）
public var isZoomMode: Bool { Device.current.isZoomed ?? false }

// MARK: - 变量-布局相关
/// 获取一个像素
public var pixelOne: CGFloat {
    if pixelOneValue < 0 {
        pixelOneValue = 1.0 / UIScreen.main.scale
    }
    return pixelOneValue
}
private var pixelOneValue = -1.f

/// bounds && nativeBounds / scale && nativeScale
public var screenBoundsSize: CGSize { UIScreen.main.bounds.size }
public var screenNativeBoundsSize: CGSize { UIScreen.main.nativeBounds.size }
public var screenScale: CGFloat { UIScreen.main.scale }
public var screenNativeScale: CGFloat { UIScreen.main.nativeScale }

/// toolBar相关frame
public var toolBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 70 : (iOSVersion >= 12.0 ? 50 : 44)) : (isLandscape ? preferredValue(regular: 44, compact: 32) : 44) + safeArea.bottom)
}

/// tabBar相关frame
public var tabBarHeight: CGFloat {
    (isPad ? (isNotchedScreen ? 65 : (iOSVersion >= 12.0 ? 50 : 49)) : (isLandscape ? preferredValue(regular: 49, compact: 32) : 49) + safeArea.bottom)
}

/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)
public var statusBarHeight: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height)
}

/// 状态栏高度(如果状态栏不可见，也会返回一个普通状态下可见的高度)
public var statusBarHeightConstant: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? (isPad ? (isNotchedScreen ? 24 : 20) : preferredValue(notched: isLandscape ? 0 : (Device.identifier == "iPhone12,1" ? 48 : ((is61InchScreen && Device.identifier != "iPhone11,8" && Device.identifier != "iPhone12,1") || is67InchScreen ? 47 : 44)), other: 20)) : UIApplication.shared.statusBarFrame.size.height)
}

/// navigationBar 的静态高度
public var navigationBarHeight: CGFloat {
    (isPad ? (iOSVersion >= 12.0 ? 50 : 44) : (isLandscape ? preferredValue(regular: 44, compact: 32) : 44))
}

/// 代表(导航栏+状态栏)，这里用于获取其高度
/// @warn 如果是用于 viewController，请使用 UIViewController(SWFrame) swf_navigationBarMaxYInViewCoordinator 代替
public var navigationContentTop: CGFloat {
    statusBarHeight + navigationBarHeight
}

/// 同上，这里用于获取它的静态常量值
public var navigationContentTopConstant: CGFloat {
    statusBarHeightConstant + navigationBarHeight
}

/// 用于获取 isNotchedScreen 设备的 insets，注意对于无 Home 键的新款 iPad 而言，它不一定有物理凹槽，但因为使用了 Home Indicator，所以它的 safeAreaInsets 也是非0。
/// @NEW_DEVICE_CHECKER
public var safeArea: UIEdgeInsets {
    if !isNotchedScreen {
        return .zero
    }
    
    if isPad {
        return .init(top: 24, left: 0, bottom: 20, right: 0)
    }
    
    if safeAreaInfo == nil {
        safeAreaInfo = [
            // iPhone 13 mini
            "iPhone14,4": [
                .portrait: .init(top: 50, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 50, bottom: 21, right: 50)
            ],
            "iPhone14,4-Zoom": [
                .portrait: .init(top: 43, left: 0, bottom: 29, right: 0),
                .landscapeLeft: .init(top: 0, left: 43, bottom: 21, right: 43)
            ],
            // iPhone 13
            "iPhone14,5": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone14,5-Zoom": [
                .portrait: .init(top: 39, left: 0, bottom: 28, right: 0),
                .landscapeLeft: .init(top: 0, left: 39, bottom: 21, right: 39)
            ],
            // iPhone 13 Pro
            "iPhone14,2": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone14,2-Zoom": [
                .portrait: .init(top: 39, left: 0, bottom: 28, right: 0),
                .landscapeLeft: .init(top: 0, left: 39, bottom: 21, right: 39)
            ],
            // iPhone 13 Pro Max
            "iPhone14,3": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone14,3-Zoom": [
                .portrait: .init(top: 41, left: 0, bottom: 29 + 2.0 / 3.0, right: 0),
                .landscapeLeft: .init(top: 0, left: 41, bottom: 21, right: 41)
            ],
            // iPhone 12 mini
            "iPhone13,1": [
                .portrait: .init(top: 50, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 50, bottom: 21, right: 50)
            ],
            "iPhone13,1-Zoom": [
                .portrait: .init(top: 43, left: 0, bottom: 29, right: 0),
                .landscapeLeft: .init(top: 0, left: 43, bottom: 21, right: 43)
            ],
            // iPhone 12
            "iPhone13,2": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone13,2-Zoom": [
                .portrait: .init(top: 39, left: 0, bottom: 28, right: 0),
                .landscapeLeft: .init(top: 0, left: 39, bottom: 21, right: 39)
            ],
            // iPhone 12 Pro
            "iPhone13,3": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone13,3-Zoom": [
                .portrait: .init(top: 39, left: 0, bottom: 28, right: 0),
                .landscapeLeft: .init(top: 0, left: 39, bottom: 21, right: 39)
            ],
            // iPhone 12 Pro Max
            "iPhone13,4": [
                .portrait: .init(top: 47, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 47, bottom: 21, right: 47)
            ],
            "iPhone13,4-Zoom": [
                .portrait: .init(top: 41, left: 0, bottom: 29 + 2.0 / 3.0, right: 0),
                .landscapeLeft: .init(top: 0, left: 41, bottom: 21, right: 41)
            ],
            // iPhone 11
            "iPhone12,1": [
                .portrait: .init(top: 48, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 48, bottom: 21, right: 48)
            ],
            "iPhone12,1-Zoom": [
                .portrait: .init(top: 44, left: 0, bottom: 31, right: 0),
                .landscapeLeft: .init(top: 0, left: 44, bottom: 21, right: 44)
            ],
            // iPhone 11 Pro Max
            "iPhone12,5": [
                .portrait: .init(top: 44, left: 0, bottom: 34, right: 0),
                .landscapeLeft: .init(top: 0, left: 44, bottom: 21, right: 44)
            ],
            "iPhone12,5-Zoom": [
                .portrait: .init(top: 40, left: 0, bottom: 30 + 2.0 / 3.0, right: 0),
                .landscapeLeft: .init(top: 0, left: 40, bottom: 21, right: 40)
            ]
        ]
    }
    
    var deviceKey = Device.identifier
    if safeAreaInfo?[deviceKey] == nil {
        deviceKey = "iPhone14,2" // 默认按最新的 iPhone 13 Pro 处理，因为新出的设备肯定更大概率与上一代设备相似
    }
    if isZoomMode {
        deviceKey += "-Zoom"
    }
    
    var orientationKey: UIInterfaceOrientation = .portrait
    let orientation = UIApplication.shared.statusBarOrientation
    switch orientation {
    case .landscapeLeft, .landscapeRight:
        orientationKey = .landscapeLeft
    default:
        break
    }
    
    var insets = safeAreaInfo![deviceKey]![orientationKey]!
    if orientation == .portraitUpsideDown {
        insets = .init(top: insets.bottom, left: insets.left, bottom: insets.top, right: insets.right)
    } else if orientation == .landscapeRight {
        insets = .init(top: insets.top, left: insets.right, bottom: insets.bottom, right: insets.left)
    }
    return insets
}
private var safeAreaInfo: [String : [UIInterfaceOrientation : UIEdgeInsets]]?

// MARK: - Other
public typealias KVTuple = (key: Any, value: Any?)
public var dateTimeFormatStyle1: String { "yyyy/MM/dd HH:mm:ss" }
