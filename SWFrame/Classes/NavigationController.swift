//
//  NavigationController.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import HBDNavigationBar

public class NavigationController: HBDNavigationController {
    
    override public func viewDidLoad() {
            super.viewDidLoad()
            
            // YJX_TODO 临时注释
    //        self.navigationBar.isTranslucent = false
    //        self.navigationBar.backIndicatorImage = R.image.ic_nav_back()
    //        self.navigationBar.backIndicatorTransitionMaskImage = R.image.ic_nav_back()
    //
    //        themeService.rx
    //            .bind({ $0.secondary }, to: self.navigationBar.rx.tintColor)
    //            .bind({ $0.primaryDark }, to: self.navigationBar.rx.barTintColor)
    //            .bind({ [NSAttributedString.Key.foregroundColor: $0.text] }, to: self.navigationBar.rx.titleTextAttributes)
    //            .disposed(by: rx.disposeBag)
    }
        
    override public var shouldAutorotate: Bool {
        return (self.topViewController?.shouldAutorotate)!
    }
        
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
        
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return (self.topViewController?.preferredStatusBarStyle)!
    }

}

