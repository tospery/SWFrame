//
//  BaseViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import RxCocoa
import QMUIKit
import SwifterSwift
import Toast_Swift
import URLNavigator

open class BaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()
    public let navigator: NavigatorType
    
    public var hidesNavigationBar = false
    public var hidesNavBottomLine = false
    
    public var loading = false
    public var error: Error?
    
    public var contentTop: CGFloat {
        return self.hidesNavigationBar ? 0 : self.navigationBar.height
    }
    
    public var contentBottom: CGFloat {
        var height = safeBottom
        if let tabBar = self.tabBarController?.tabBar, !tabBar.isHidden, !self.hidesBottomBarWhenPushed {
            height += tabBar.height
        }
        return height
    }
    
    public var contentFrame: CGRect {
        return CGRect(x: 0, y: self.contentTop, width: self.view.width, height: self.view.height - self.contentTop - self.contentBottom)
    }
    
    lazy public var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar()
        //navigationBar.layer.zPosition = .greatestFiniteMagnitude
        navigationBar.sizeToFit()
        return navigationBar
    }()
    
    // MARK: - Init
    public init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.hidesNavigationBar = boolMember(reactor.parameters, Parameter.hideNavBar, false)
        self.hidesNavBottomLine = boolMember(reactor.parameters, Parameter.hideNavLine, false)
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
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.navigationBar)
        if self.hidesNavigationBar {
            self.navigationBar.isHidden = true
        } else {
            if self.hidesNavBottomLine {
                self.navigationBar.qmui_borderPosition = QMUIViewBorderPosition(rawValue: 0)
            }
            if self.navigationController?.viewControllers.count ?? 0 > 1 {
                self.navigationBar.addBackButtonToLeft().rx.tap.subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else { return }
                    self.navigationController?.popViewController()
                }).disposed(by: self.disposeBag)
            } else {
                if self.qmui_isPresented() {
                    self.navigationBar.addCloseButtonToLeft().rx.tap.subscribe(onNext: { [weak self] _ in
                        guard let `self` = self else { return }
                        self.dismiss(animated: true, completion: nil)
                    }).disposed(by: self.disposeBag)
                }
            }
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.bringSubviewToFront(self.navigationBar)
    }
    
    // MARK: - Method
    public func bind(reactor: BaseViewReactor) {
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
     
}

public extension Reactive where Base: BaseViewController {
    
    func loading(active: Bool = false, text: String? = nil) -> Binder<Bool> {
        return Binder(self.base) { viewController, loading in
            viewController.loading = loading
            if active, viewController.qmui_isViewLoadedAndVisible() {
                let view = viewController.view!
                view.isUserInteractionEnabled = !loading
                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
            }
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            if let error = error as? AppError, viewController.error == nil {
                switch error {
                case .expire:
                    viewController.navigator.present(UIApplication.shared.scheme + "://login", wrap: NavigationController.self)
                default:
                    break
                }
            }
            viewController.error = error
        }
    }
    
//    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
//        return Binder(self.base) { viewController, attr in
//            viewController.emptyDataSetImageTintColor.accept(attr)
//        }
//    }
    
//    var emptyDataSetTap: ControlEvent<Void> {
//        let source = self.base.emptyDataSetSubject.map{ _ in }
//        return ControlEvent(events: source)
//    }
    
}
