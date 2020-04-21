//
//  TabBarViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import URLNavigator

open class TabBarViewController: ScrollViewController {
    
    public let innerTabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        return tabBarController
    }()
    
    public override init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        super.init(navigator, reactor)
        self.hidesNavigationBar = boolMember(reactor.parameters, Parameter.hideNavBar, true)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(self.innerTabBarController)
        self.view.addSubview(self.innerTabBarController.view)
        self.innerTabBarController.didMove(toParent: self)
    }
    
    open override var shouldAutorotate: Bool {
        return self.innerTabBarController.selectedViewController?.shouldAutorotate ?? false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.innerTabBarController.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.innerTabBarController.selectedViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
}

