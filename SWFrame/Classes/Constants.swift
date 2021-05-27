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
