//
//  NormalCollectionItem.swift
//  Kujia
//
//  Created by 杨建祥 on 2020/4/19.
//  Copyright © 2020 杨建祥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

open class NormalCollectionItem: BaseCollectionItem, Reactor {
    
    public typealias Action = NoAction
    
    public struct State {
        public var showIndicator = true
        public var title: String?
        public var detail: String?
        public var avatar: ImageSource?
    }
    
    public var initialState = State()
    
    required public init(_ model: ModelType) {
        super.init(model)
    }
    
    open func transform(state: Observable<State>) -> Observable<State> {
        return state
    }
    
}
