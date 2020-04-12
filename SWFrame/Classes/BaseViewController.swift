//
//  BaseViewController.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import RxCocoa
import QMUIKit
import SwifterSwift
import URLNavigator

open class BaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()
    public let navigator: NavigatorType
    
    public var loading = false
    public var error: Error?
    
    var contentTop: CGFloat {
        var height = statusBarHeightConstant
        if let navBar = self.navigationController?.navigationBar, !navBar.isHidden {
            height += navBar.height
        }
        return height
    }
    
    var contentBottom: CGFloat {
        var height = safeBottom
        if let tabBar = self.tabBarController?.tabBar, !tabBar.isHidden, !self.hidesBottomBarWhenPushed {
            height += tabBar.height
        }
        return height
    }
    
    var contentFrame: CGRect {
        return CGRect(x: 0, y: self.contentTop, width: self.view.width, height: self.view.height - self.contentTop - self.contentBottom)
    }
    
    lazy var backBarItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage.back.qmui_image(withTintColor: .red), style: .plain, target: nil, action: nil)
    }()

    lazy var closeBarItem: UIBarButtonItem = {
        let abc = UIImage.close
        return UIBarButtonItem(image: UIImage.close.qmui_image(withTintColor: .red), style: .plain, target: nil, action: nil)
    }()
    
//    public lazy var navigationBar: NavigationBar = {
//        let navigationBar = NavigationBar()
//        //navigationBar.layer.zPosition = .greatestFiniteMagnitude
//        navigationBar.sizeToFit()
//        return navigationBar
//    }()
    
    // MARK: - Init
    public init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            self.navigationItem.leftBarButtonItem = self.backBarItem
        } else {
            if self.qmui_isPresented() {
                self.navigationItem.leftBarButtonItem = self.closeBarItem
            } else {
                self.navigationItem.leftBarButtonItem = nil
            }
        }
        
//        self.navigationController?.navigationBar.isHidden = true
//        self.view.addSubview(self.navigationBar)
        
//        if self.navigationController?.viewControllers.count ?? 0 > 1 {
//            let backButton = self.navigationBar.addBackButtonToLeft()
//            backButton.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
//                guard let `self` = self else { return }
//                self.navigationController?.popViewController()
//            }).disposed(by: self.disposeBag)
//        } else {
//            if self.presentingViewController != nil {
//                let closeButton = self.navigationBar.addCloseButtonToLeft()
//                closeButton.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
//                    guard let `self` = self else { return }
//                    self.dismiss(animated: true, completion: nil)
//                }).disposed(by: self.disposeBag)
//            }
//        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.view.bringSubviewToFront(self.navigationBar)
    }
    
    // MARK: - Method
    public func bind(reactor: BaseViewReactor) {
        // reactor.viewController = self
        //self.navigationBar.isHidden = reactor.hidesNavigationBar
        //self.navigationBar.qmui_borderLayer?.isHidden = reactor.hidesNavBottomLine
        
        // bind
        self.backBarItem.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.navigationController?.popViewController()
        }).disposed(by: self.disposeBag)
        self.closeBarItem.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
    
//    public func addNavigationBar() {
//        if self.navigationBar.superview == nil {
//            self.view.addSubview(self.navigationBar)
//        }
//    }
//
//    public func removeNavigationBar() {
//        if self.navigationBar.superview != nil {
//            self.navigationBar.removeFromSuperview()
//        }
//    }
    
}

