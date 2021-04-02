//
//  UIToolbarExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit

public extension UIToolbar {
    
    static var height: CGFloat {
        (UIDevice.isIPad ? (UIScreen.isNotched ? 70 : (UIDevice.iosVersionDouble >= 12.0 ? 50 : 44)) : (isLandscape ? alternate(regular: 44, compact: 32) : 44) +  UIScreen.safeBottom)
    }

}
