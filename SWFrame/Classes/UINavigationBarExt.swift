//
//  UINavigationBarExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit

public extension UINavigationBar {
    
    static var height: CGFloat {
        (UIDevice.isIPad ? (UIDevice.iosVersionDouble >= 12.0 ? 50 : 44) : (isLandscape ? alternate(regular: 44, compact: 32) : 44))
    }
    
    static var contentHeight: CGFloat {
        (statusBarHeight + self.height)
    }
    
    static var contentHeightConstant: CGFloat {
        (statusBarHeightConstant + self.height)
    }

}
