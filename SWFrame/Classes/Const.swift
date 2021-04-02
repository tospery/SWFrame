//
//  Const.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit
import QMUIKit

public var pixelOne: CGFloat { QMUIHelper.pixelOne }

public var isLandscape: Bool { UIApplication.shared.statusBarOrientation.isLandscape }
public var isDeviceLandscape: Bool { UIDevice.current.orientation.isLandscape }

public var statusBarHeight: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height)
}
public var statusBarHeightConstant: CGFloat {
    (UIApplication.shared.isStatusBarHidden ? (UIDevice.isIPad ? (UIScreen.isNotched ? 24 : 20) : alternate(notched: (isLandscape ? 0 : 44), other: 20)) : UIApplication.shared.statusBarFrame.size.height)
}
