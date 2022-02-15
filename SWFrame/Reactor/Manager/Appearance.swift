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
        if let compatible = self as? AppearanceCompatible {
            compatible.myConfig()
        }
        
//        // NavBar
//        if (@available(iOS 13.0, *)) {
//            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
//            [appearance configureWithOpaqueBackground];
//            appearance.theme_backgroundColor = ThemeColorPicker.barTint;
//            appearance.shadowImage = [[UIImage alloc] init];
//            appearance.shadowColor = nil;
//            appearance.titleTextAttributes = @{
//                NSForegroundColorAttributeName: UIColor.orangeColor,
//                NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
//            };
//            UINavigationBar.appearance.standardAppearance = appearance;
//            UINavigationBar.appearance.scrollEdgeAppearance = appearance;
//        } else {
//            UINavigationBar.appearance.translucent = NO;
//            UINavigationBar.appearance.theme_barTintColor = ThemeColorPicker.barTint;
//            UINavigationBar.appearance.titleTextAttributes = @{
//                NSForegroundColorAttributeName: UIColor.orangeColor,
//                NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
//            };
//        }
//
//        // TabBar
//        if (@available(iOS 13.0, *)) {
//            UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
//            [appearance configureWithOpaqueBackground];
//            appearance.theme_backgroundColor = ThemeColorPicker.barTint;
//            appearance.shadowImage = [[UIImage alloc] init];
//            appearance.shadowColor = nil;
//            UITabBar.appearance.standardAppearance = appearance;
//            if (@available(iOS 15.0, *)) {
//                UITabBar.appearance.scrollEdgeAppearance = appearance;
//            }
//        } else {
//            UITabBar.appearance.translucent = NO;
//            UITabBar.appearance.theme_barTintColor = ThemeColorPicker.barTint;
//        }
        
    }
    
}

