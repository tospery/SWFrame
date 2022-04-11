//
//  BaseItem.swift
//  SWFrame
//
//  Created by liaoya on 2022/4/11.
//

import Foundation

open class BaseItem: ModelViewReactor {
    
    public var size = CGSize.zero
    public weak var parent: BaseViewReactor?
    
}
