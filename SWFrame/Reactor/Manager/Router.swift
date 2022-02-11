//
//  Router.swift
//  SWFrame
//
//  Created by liaoya on 2022/2/11.
//

import Foundation
import URLNavigator

public protocol RouterCompatible {
    func web(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType)
    func page(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType)
    func model(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType)
}

final public class Router {

    public static var shared = Router()
    
    init() {
    }
    
    public func initialize(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
//        navigator.matcher.valueConverters["type"] = { pathComponents, index in
//            guard let host = Host.init(rawValue: pathComponents[0]) else { return nil }
//            let allowedPaths = host.allowedPaths.map { $0.rawValue }
//            if allowedPaths.contains(pathComponents[index]) {
//                return pathComponents[index]
//            }
//            return nil
//        }
        if let compatible = self as? RouterCompatible {
            compatible.web(provider, navigator)
            compatible.page(provider, navigator)
            compatible.model(provider, navigator)
        }
    }

}
