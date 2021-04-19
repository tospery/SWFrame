//
//  UINavigationBarExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit

public extension UINavigationBar {
    
    static var height: CGFloat {
        SWHelper.sharedInstance().navigationBarHeight
    }
    
    static var contentHeight: CGFloat {
        SWHelper.sharedInstance().navigationContentTop
    }
    
    static var contentHeightConstant: CGFloat {
        SWHelper.sharedInstance().navigationContentTopConstant
    }

}
