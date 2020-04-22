//
//  WebViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import WebKit
import URLNavigator
import ReactorKit
import SwifterSwift
import WebViewJavascriptBridge

open class WebViewController: ScrollViewController, View {
    
    private let estimatedProgress = "estimatedProgress"
    
    public var url: URL?
    public var progressColor: UIColor?
    public var handlers = [String]()
    // public var jsHandlers: [String]?
    public var bridge: WebViewJavascriptBridge!
    
    public lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.backgroundColor = .white
        webView.sizeToFit()
        return webView
    }()
    
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
        
        self.bridge = WebViewJavascriptBridge.init(forWebView: self.webView)
        self.bridge.setWebViewDelegate(self)
        for handler in self.handlers {
            self.bridge.registerHandler(handler) { [weak self] data, callback in
                guard let `self` = self else { return }
                let method = handler.camelCasedWithoutUnderline + ":callback:"
                let result = self.myTest()
                callback!(result)
                print("")
//                let selector = NSSelectorFromString(method)
//                if self.responds(to: selector) {
//                    self.perform(selector, with: data, with: callback)
//                } else {
//                    print("找不到方法" + method)
//                }
            }
        }
        
        self.loadPage()
    }
    
    open func myTest() -> String {
        return ""
    }
    
    deinit {
        self.webView.navigationDelegate = nil
        self.webView.uiDelegate = nil
    }
    
    func progress(_ value: CGFloat) {
        self.progressView.progress(value: value, animated: true)
        if self.navigationItem.title?.isEmpty ?? true {
            self.webView.evaluateJavaScript("document.title") { [weak self] response, Error in
                guard let `self` = self else { return }
                if let title = response as? String {
                    self.navigationItem.title = title
                }
            }
        }
    }
    
    open func loadPage() {
        if let url = self.url {
            let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            self.webView.load(request)
        }
    }
    
    public func bind(reactor: WebViewReactor) {
        super.bind(reactor: reactor)
        // state
        reactor.state.map { $0.title }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: self.disposeBag)
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
}

extension WebViewController: WKUIDelegate {
    
}
