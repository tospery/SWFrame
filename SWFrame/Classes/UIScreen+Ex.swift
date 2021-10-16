//
//  UIScreen+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

public extension UIScreen {
    
    static var rawHeight: CGFloat {
        deviceHeight - navigationContentTopConstant - safeBottom
    }
    
    static var minEdge: CGFloat {
        self.main.bounds.minEdge
    }
    
    static var maxEdge: CGFloat {
        self.main.bounds.maxEdge
    }
    
}
