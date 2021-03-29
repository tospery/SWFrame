//
//  WKWebViewExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/13.
//

import UIKit
import WebKit
import QMUIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: WKWebView {

    var loadHTMLString: Binder<String> {
        return Binder(self.base) { webView, string in
            webView.loadHTMLString(string, baseURL: nil)
        }
    }

    var load: Binder<URL> {
        return Binder(self.base) { webView, url in
            webView.load(URLRequest(url: url))
        }
    }

}
