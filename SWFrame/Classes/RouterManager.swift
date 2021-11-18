//
//  RouterManager.swift
//  SWFrame
//
//  Created by liaoya on 2021/11/18.
//

import UIKit
import URLNavigator

final public class RouterManager: NSObject {
    
    public static let shared = RouterManager()
    
    override init() {
        super.init()
    }
    
    public func setup(provider: ProviderType, navigator: NavigatorType) {
//        self.provider = provider;
//        self.navigator = navigator;
//        JLRoutes.globalRoutes[kOCFPatternLogin] = ^BOOL(NSDictionary *parameters) {
//            Class cls = NSClassFromString(@"LoginViewReactor");
//            if (![cls isSubclassOfClass:OCFLoginViewReactor.class]) {
//                return NO;
//            }
//            OCFLoginViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
//            return [navigator presentReactor:reactor animated:YES completion:nil] != nil;
//        };
//        JLRoutes.globalRoutes[kOCFPatternAny] = ^BOOL(NSDictionary *parameters) {
//            Class cls = NSClassFromString(@"WebViewReactor");
//            if (![cls isSubclassOfClass:OCFWebViewReactor.class]) {
//                return NO;
//            }
//            OCFWebViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
//            return [navigator pushReactor:reactor animated:YES] != nil;
//        };
    }
    
}
