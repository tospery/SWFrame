//
//  Constant.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit
import QMUIKit

// MARK: - Common
public var isDebug: Bool { SWHelper.sharedInstance().isDebug }

public var isPad: Bool { QMUIHelper.isIPad }
public var isPod: Bool { QMUIHelper.isIPod }
public var isPhone: Bool { QMUIHelper.isIPhone }
public var isSimulator: Bool { QMUIHelper.isSimulator }
public var isMac: Bool { QMUIHelper.isMac }

public var iOSVersion: Double { (UIDevice.current.systemVersion as NSString).doubleValue }
public var iOSVersionNumber: Int { QMUIHelper.numbericOSVersion() }

public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

public var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
public var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
public var deviceWidth: CGFloat { min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
public var deviceHeight: CGFloat { max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) }
public var applicationWidth: CGFloat { QMUIHelper.applicationSize.width }
public var applicationHeight: CGFloat { QMUIHelper.applicationSize.height }

public var isNotchedScreen: Bool { QMUIHelper.isNotchedScreen }
public var isRegularScreen: Bool { QMUIHelper.isRegularScreen }
public var isCompactScreen: Bool { !QMUIHelper.isRegularScreen }

public var isSmallScreen: Bool { deviceWidth <= 320 }
public var isMiddleScreen: Bool { deviceWidth > 320 && deviceWidth < 414 }
public var isLargeScreen: Bool { deviceWidth >= 414 }

public var statusBarHeight: CGFloat { SWHelper.sharedInstance().statusBarHeight }
public var statusBarHeightConstant: CGFloat { SWHelper.sharedInstance().statusBarHeightConstant }
public var navigationBarHeight: CGFloat { SWHelper.sharedInstance().navigationBarHeight }
public var navigationContentTop: CGFloat { SWHelper.sharedInstance().navigationContentTop }
public var navigationContentTopConstant: CGFloat { SWHelper.sharedInstance().navigationContentTopConstant }
public var tabBarHeight: CGFloat { SWHelper.sharedInstance().tabBarHeight }
public var toolBarHeight: CGFloat { SWHelper.sharedInstance().toolBarHeight }

public var safeArea: UIEdgeInsets { QMUIHelper.safeAreaInsetsForDeviceWithNotch }
public var safeBottom: CGFloat { safeArea.bottom }

public var pixelOne: CGFloat { QMUIHelper.pixelOne }

// MARK: - Other
public typealias KVTuple = (key: Any, value: Any?)
public var dateTimeFormatStyle1: String { "yyyy/MM/dd HH:mm:ss" }
