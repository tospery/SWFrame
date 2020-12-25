//
//  WebViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import WebKit
import URLNavigator
import ReactorKit
import SwifterSwift

open class WebViewController: ScrollViewController, View {
    
    public let estimatedProgress = "estimatedProgress"
    
    public var webView: WKWebView!
    public var url: URL?
    public var progressColor: UIColor?
    public var handlers = [String]()
    // public var jsHandlers: [String]?
    // public var bridge: WebViewJavascriptBridge!
    
//    public lazy var webConfig: WKWebViewConfiguration = {
//        let config = WKWebViewConfiguration.init()
//        config.processPool = WKProcessPool.shared
//        if #available(iOS 11, *) {
//            if let cookies = HTTPCookieStorage.shared.cookies {
//                let store = config.websiteDataStore.httpCookieStore
//                for cookie in cookies {
//                    store.setCookie(cookie, completionHandler: nil)
//                }
//            }
//        }
//        return config
//    }()
    
//    public lazy var webView: WKWebView = {
//        // configuration在传递给WKWebView后不能修改
//        let configuration = WKWebViewConfiguration.init()
//        configuration.processPool = WKProcessPool.shared
//        let webView = WKWebView(frame: .zero, configuration: configuration)
//        webView.backgroundColor = .white
//        webView.sizeToFit()
//        return webView
//    }()

    public lazy var progressView: WebProgressView = {
        let view = WebProgressView(frame: .zero)
        view.sizeToFit()
        return view
    }()
    
    public init(_ navigator: NavigatorType, _ reactor: WebViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
        self.url = urlMember(reactor.parameters, Parameter.url, nil)
        self.progressColor = colorMember(reactor.parameters, Parameter.progressColor, nil)
        self.handlers = arrayMember(reactor.parameters, Parameter.handers, nil) as? [String] ?? []
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = self.createWebView()
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        self.view.addSubview(self.webView)
        self.webView.frame = self.contentFrame
        
        self.progressView.barView.backgroundColor = self.progressColor ?? UIColor.orange
        self.view.addSubview(self.progressView)
        self.progressView.frame = CGRect(x: 0, y: self.contentTop, width: self.view.width, height: 1.5)
        
        self.webView.rx.observeWeakly(CGFloat.self, self.estimatedProgress, options: .new).subscribe(onNext: { [weak self] value in
            guard let `self` = self, let value = value else { return }
            self.progress(value)
        }).disposed(by: self.disposeBag)
        
//        #if DEBUG
//        WebViewJavascriptBridge.enableLogging()
//        #endif
//        self.bridge = WebViewJavascriptBridge.init(forWebView: self.webView)
//        self.bridge.setWebViewDelegate(self)
//        weak var weakSelf = self
//        for handler in self.handlers {
//            self.bridge.registerHandler(handler) { [weak self] data, callback in
//                guard let `self` = self else { return }
//                let result = self.handle(handler, data)
//                callback!(result)
//            }
//        }
        
        self.loadPage()
    }
    
//    open override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.bridge.setWebViewDelegate(self)
//    }
//
//    open override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.bridge.setWebViewDelegate(nil)
//    }

    deinit {
        if self.webView != nil {
            self.webView.navigationDelegate = nil
            self.webView.uiDelegate = nil
        }
    }
    
    public func progress(_ value: CGFloat) {
        self.progressView.progress(value: value, animated: true)
        if self.navigationBar.titleLabel.text?.isEmpty ?? true {
            self.webView.evaluateJavaScript("document.title") { [weak self] response, Error in
                guard let `self` = self else { return }
                if let title = response as? String {
                    self.navigationBar.titleLabel.text = title
                }
            }
        }
    }

    open func createWebView() -> WKWebView {
        // configuration在传递给WKWebView后不能修改
        let configuration = WKWebViewConfiguration.init()
        configuration.userContentController = .init()
        for handler in self.handlers {
            if !handler.isEmpty {
                configuration.userContentController.add(self, name: handler)
            }
        }
        let webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.backgroundColor = .white
        webView.sizeToFit()
        return webView
    }

    open func loadPage() {
        if let url = self.url {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            self.webView.load(request)
        }
    }
    
    open func handle(_ handler: String, _ data: Any) {
        
    }
    
    public func bind(reactor: WebViewReactor) {
        super.bind(reactor: reactor)
        // state
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
  
    open override func didClosed() {
        for handler in self.handlers {
            if !handler.isEmpty {
                self.webView.configuration.userContentController.removeScriptMessageHandler(forName: handler)
            }
        }
    }
    
//    func saveCookies(_ cookies: [HTTPCookie]) {
//        // DDLogDebug("【SWFrame】保存Cookies: \(cookies)")
//        for cookie in cookies {
//            HTTPCookieStorage.shared.setCookie(cookie)
//        }
//    }
    
//    @available(iOS 11.0, *)
//    func syncCookies(_ cookieStore: WKHTTPCookieStore) {
//        guard let cookies = HTTPCookieStorage.shared.cookies else { return }
//        for cookie in cookies {
//            cookieStore.setCookie(cookie, completionHandler: nil)
//        }
//    }
    
}

extension WebViewController: WKNavigationDelegate {

    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url?.absoluteString)
        decisionHandler(.allow)
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        if #available(iOS 11, *) {
//            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
//                let abc = HTTPCookieStorage.shared.cookies
//                print("")
//                // self.saveCookies(cookies)
//            }
//        } else {
//            if let response = navigationResponse.response as? HTTPURLResponse,
//                let headerFields = response.allHeaderFields as? [String: String],
//                let url = response.url {
//                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
//                self.saveCookies(cookies)
//            }
//        }
        decisionHandler(.allow)
    }

    open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame ?? false == false {
            if let url = navigationAction.request.url {
                self.navigator.push(url)
            }
        }
        return nil
    }
}

extension WebViewController: WKUIDelegate {
    
}

extension WebViewController: WKScriptMessageHandler {
    
    open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("\(message.name): \(message.body)")
        self.handle(message.name, message.body)
    }
    
}


public extension Reactive where Base: WebViewController {
    var url: Binder<URL?> {
        return Binder(self.base) { viewController, url in
            viewController.url = url
        }
    }
}
