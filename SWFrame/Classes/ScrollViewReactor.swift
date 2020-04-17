//
//  ScrollViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import URLNavigator

open class ScrollViewReactor: BaseViewReactor {
    
    // public var shouldRefresh = false
    // public var shouldLoadMore = false
    
//    open var pageStart = 0
//    open var pageIndex = 0
//    open var pageSize = 10
    
    open var pageStart: Int { 1 }
    open var pageIndex = 1
    open var pageSize = 20
    
    public required init(_ provider: ProviderType, _ parameters: Dictionary<String, Any>?) {
        super.init(provider, parameters)
        // self.shouldRefresh = boolMember(parameters, Parameter.shouldPullToRefresh, false)
        // self.shouldLoadMore = boolMember(parameters, Parameter.shouldInfiniteScrolling, false)
    }
    
}
