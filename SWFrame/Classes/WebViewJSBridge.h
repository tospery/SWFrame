//
//  WebViewJSBridge.h
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

#import <Foundation/Foundation.h>
#import "WebViewJSBridgeBase.h"
#import <WebKit/WebKit.h>

@interface WKWebViewJSBridge : NSObject<WKNavigationDelegate, WebViewJSBridgeBaseDelegate>

+ (instancetype)bridgeForWebView:(WKWebView*)webView;
+ (void)enableLogging;

- (void)registerHandler:(NSString*)handlerName handler:(WVJSBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJSBResponseCallback)responseCallback;
- (void)reset;
- (void)setWebViewDelegate:(id)webViewDelegate;
- (void)disableJSAlertBoxSafetyTimeout;

@end
