//
//  UINavigationBar+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit

public extension UINavigationBar {
    
    static var height: CGFloat {
        SWFHelper.sharedInstance().navigationBarHeight
    }
    
    static var contentHeight: CGFloat {
        SWFHelper.sharedInstance().navigationContentTop
    }
    
    static var contentHeightConstant: CGFloat {
        SWFHelper.sharedInstance().navigationContentTopConstant
    }

}
