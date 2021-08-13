//
//  BaseViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SwifterSwift
import URLNavigator

public let statusBarService = BehaviorRelay<UIStatusBarStyle>(value: .default)

open class BaseViewController: UIViewController {
    
    public var result: Any?
    public var callback: AnyObserver<Any>?
    public var disposeBag = DisposeBag()
    public let navigator: NavigatorType
    
    public var hidesNavigationBar   = false
    public var hidesNavBottomLine   = false
    public var transparetNavBar     = false {
        didSet {
            self.navigationBar.isTransparet = self.transparetNavBar
        }
    }
    
    public var isActivating = false
    public var error: Error?
    
    public var contentTop: CGFloat {
        var height = self.navigationBar.height
        if self.hidesNavigationBar ||
            self.transparetNavBar ||
            self.navigationBar.isHidden ||
            self.navigationBar.isTransparet {
            if let navBar = self.navigationController?.navigationBar,
               navBar.isTranslucent == false {
                height = UINavigationBar.height
            } else {
                height = 0
            }
        }
        return height
    }
    
    public var contentBottom: CGFloat {
        var height = 0.f
        if let tabBar = self.tabBarController?.tabBar,
            tabBar.isHidden == false,
            self.qmui_previous == nil,
            self.hidesBottomBarWhenPushed == false {
            height += tabBar.height
        }
        return height
    }
    
    public var contentFrame: CGRect {
        return CGRect(x: 0, y: self.contentTop, width: self.view.width, height: self.view.height - self.contentTop - self.contentBottom)
    }
    
    // public let navigationBar = NavigationBar()
    
    lazy public var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar()
        navigationBar.layer.zPosition = .greatestFiniteMagnitude
        navigationBar.sizeToFit()
        return navigationBar
    }()
    
    // MARK: - Init
    public init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.hidesNavigationBar = reactor.parameters.bool(for: Parameter.hideNavBar) ?? false
        self.hidesNavBottomLine = reactor.parameters.bool(for: Parameter.hideNavLine) ?? false
        self.transparetNavBar = reactor.parameters.bool(for: Parameter.transparetNavBar) ?? false
        self.callback = reactor.parameters[Parameter.observer] as? AnyObserver<Any>
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if self.result != nil {
            self.callback?.onNext(self.result!)
        }
        self.callback?.onCompleted()
        #if DEBUG
        logger.print("\(self.className)已销毁！！！", module: .swframe)
        #endif
    }
    
    // MARK: - View
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        if self.hidesNavigationBar {
            self.navigationBar.isHidden = true
        } else {
            if self.transparetNavBar {
                self.navigationBar.transparet()
            } else {
                if self.hidesNavBottomLine {
                    self.navigationBar.qmui_borderPosition = QMUIViewBorderPosition(rawValue: 0)
                }
            }
            if self.navigationController?.viewControllers.count ?? 0 > 1 {
                self.navigationBar.addBackButtonToLeft().rx.tap.subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else { return }
                    self.navigationController?.popViewController(animated: true, { [weak self] in
                        guard let `self` = self else { return }
                        self.didClosed()
                    })
                }).disposed(by: self.disposeBag)
            } else {
                if self.qmui_isPresented() {
                    self.navigationBar.addCloseButtonToLeft().rx.tap.subscribe(onNext: { [weak self] _ in
                        guard let `self` = self else { return }
                        self.dismiss(animated: true) { [weak self] in
                            guard let `self` = self else { return }
                            self.didClosed()
                        }
                    }).disposed(by: self.disposeBag)
                }
            }
        }
        
        if let gestureRecognizer = self.navigationController?.interactivePopGestureRecognizer {
            gestureRecognizer.addTarget(self, action: #selector(handleInteractivePopGestureRecognizer(_:)))
        }
        
        statusBarService.map { _ in () }.skip(1).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.setNeedsStatusBarAppearanceUpdate()
        }).disposed(by: self.rx.disposeBag)
        
        themeService.rx
            .bind({ $0.borderColor }, to: self.navigationBar.rx.lineColor)
            .bind({ $0.foregroundColor }, to: [
                self.navigationBar.rx.titleColor,
                self.navigationBar.rx.itemColor
            ])
            .disposed(by: self.rx.disposeBag)
        if !self.transparetNavBar {
            themeService.rx
                .bind({ $0.backgroundColor }, to: self.navigationBar.rx.barColor)
                .disposed(by: self.rx.disposeBag)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bringSubviewToFront(self.navigationBar)
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarService.value
    }
    
    // MARK: - Method
    open func bind(reactor: BaseViewReactor) {
        // bind
//        self.backBarItem.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
//            guard let `self` = self else { return }
//            self.navigationController?.popViewController()
//        }).disposed(by: self.disposeBag)
//        self.closeBarItem.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
//            guard let `self` = self else { return }
//            self.dismiss(animated: true, completion: nil)
//        }).disposed(by: self.disposeBag)
    }
    
    open func didClosed() {
        // self.callback?.onCompleted()
    }
    
    @objc func handleInteractivePopGestureRecognizer(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .ended:
            guard let superview = self.navigationController?.topViewController?.view.superview else { return }
            if superview.frame.minX == 0.f {
                self.didClosed()
            }
        default: break
        }
    }

}
