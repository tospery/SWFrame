//
//  TabBarViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator
import ESTabBarController_swift

open class TabBarViewController: ScrollViewController {
    
//    lazy public var safeBottomView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .green
//        view.isHidden = !isNotchedScreen
//        view.sizeToFit()
//        return view
//    }()

    public let tab: ESTabBarController = {
        let tabBarController = ESTabBarController()
        // tabBarController.tabBar.isTranslucent = false
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
        self.addChild(self.tab)
        self.view.addSubview(self.tab.view)
        self.tab.view.frame = self.contentFrame
        self.tab.didMove(toParent: self)

//        self.view.addSubview(self.safeBottomView)
//        self.safeBottomView.frame = CGRect(x: 0, y: self.tab.view.bottom, width: self.view.width, height: safeBottom)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    open override var shouldAutorotate: Bool {
        return self.tab.selectedViewController?.shouldAutorotate ?? false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.tab.selectedViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.tab.selectedViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
}

//open class TabBarController: UITabBarController {
//
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    open override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    open override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
//
//    open override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
////        if #available(iOS 11.0, *), isNotchedScreen {
////            for view in self.view.subviews {
////                if let tabBar = view as? UITabBar {
////                    tabBar.frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.size.width, height: tabBarHeight)
////                }
////            }
////        }
//    }
//
//}
