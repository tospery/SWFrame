//
//  Appearance.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit
import RxSwift

public protocol AppearanceCompatible {
    func myConfig()
}

final public class Appearance {
    
    public let disposeBag = DisposeBag()
    
    public static var shared = Appearance()
    
    public init() {
    }
    
    public func config() {
        // NavBar
//        let appearance = NavigationBar.appearance()
////        appearance.theme.itemColor = themeService.attribute { $0.primaryColor }
//        appearance.theme.barColor = themeService.attribute { $0.lightColor }
//        appearance.theme.lineColor = themeService.attribute { $0.borderColor }
//        appearance.theme.titleColor = themeService.attribute { $0.foregroundColor }
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance.init()
            appearance.configureWithOpaqueBackground()
            appearance.theme.backgroundColor = themeService.attribute { $0.lightColor }
            appearance.shadowImage = UIImage.init()
            appearance.shadowColor = nil
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.background,
                .font: UIFont.bold(17)
            ]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().theme.backgroundColor = themeService.attribute { $0.lightColor }
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.background,
                .font: UIFont.bold(17)
            ]
        }
        
        // TabBar
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance.init()
            appearance.configureWithOpaqueBackground()
            appearance.theme.backgroundColor = themeService.attribute { $0.lightColor }
//            appearance.shadowImage = UIImage.init()
//            appearance.shadowColor = nil
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        } else {
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().theme.backgroundColor = themeService.attribute { $0.lightColor }
        }
        
        if let compatible = self as? AppearanceCompatible {
            compatible.myConfig()
        }
    }
    
}

