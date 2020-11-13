//
//  UIScreenExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

public extension UIScreen {
    
    public enum WidthPoint {
        case pt320
        case pt375
        case pt414
    }
    
    static var widthPoint: WidthPoint {
        switch self.width {
        case 320: return .pt320
        case 375: return .pt375
        case 414: return .pt414
        default: return .pt375
        }
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}
