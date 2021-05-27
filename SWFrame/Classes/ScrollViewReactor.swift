//
//  ScrollViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import URLNavigator

open class ScrollViewReactor: BaseViewReactor {
    
    open var pageStart: Int { 1 }
    open var pageIndex = 1
    open var pageSize = 20
    
    public required init(_ provider: ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
    }
    
}
