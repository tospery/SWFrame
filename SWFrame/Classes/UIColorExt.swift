//
//  UIColorExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import SwifterSwift

public extension UIColor {
    
    static var background: UIColor {
        themeService.type.associatedObject.backgroundColor
    }

    static var foreground: UIColor {
        themeService.type.associatedObject.foregroundColor
    }

    static var light: UIColor {
        themeService.type.associatedObject.lightColor
    }

    static var dark: UIColor {
        themeService.type.associatedObject.darkColor
    }

    static var dim: UIColor {
        themeService.type.associatedObject.dimColor
    }

    static var bright: UIColor {
        themeService.type.associatedObject.brightColor
    }

    static var primary: UIColor {
        themeService.type.associatedObject.primaryColor
    }

    static var secondary: UIColor {
        themeService.type.associatedObject.secondaryColor
    }

    static var title: UIColor {
        themeService.type.associatedObject.titleColor
    }

    static var content: UIColor {
        themeService.type.associatedObject.contentColor
    }
    
    static var header: UIColor {
        themeService.type.associatedObject.headerColor
    }

    static var footer: UIColor {
        themeService.type.associatedObject.footerColor
    }

    static var border: UIColor {
        themeService.type.associatedObject.borderColor
    }
    
    static var corner: UIColor {
        themeService.type.associatedObject.cornerColor
    }

    static var separator: UIColor {
        themeService.type.associatedObject.separatorColor
    }

    static var indicator: UIColor {
        themeService.type.associatedObject.indicatorColor
    }
    
    static var special1: UIColor {
        themeService.type.associatedObject.special1Color
    }

    static var special2: UIColor {
        themeService.type.associatedObject.special2Color
    }

    static var special3: UIColor {
        themeService.type.associatedObject.special3Color
    }
    
    static var special4: UIColor {
        themeService.type.associatedObject.special4Color
    }
    
    static var special5: UIColor {
        themeService.type.associatedObject.special5Color
    }
    
    static var special6: UIColor {
        themeService.type.associatedObject.special6Color
    }
    
    static var special7: UIColor {
        themeService.type.associatedObject.special7Color
    }
    
    static var special8: UIColor {
        themeService.type.associatedObject.special8Color
    }
    
    static var special9: UIColor {
        themeService.type.associatedObject.special9Color
    }
    
    func image(size: CGSize = .init(100)) -> UIImage {
        return .init(color: self, size: size)
    }
    
}
