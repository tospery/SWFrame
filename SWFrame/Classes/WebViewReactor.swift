//
//  WebViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import ReactorKit

open class WebViewReactor: ScrollViewReactor, Reactor {
    
    public typealias Action = NoAction
    
    public struct State {
        var title: String?
    }
    
    public var initialState = State()
    
    public required init(_ provider: ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        var handlers = self.parameters[Parameter.handers] as? [String] ?? []
        handlers.append("appHandler")
        self.parameters[Parameter.handers] = handlers
        self.initialState = State(
            title: self.title
        )
    }
    
}
