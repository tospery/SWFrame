//
//  NormalCollectionItem.swift
//  Kujia
//
//  Created by 杨建祥 on 2020/4/19.
//  Copyright © 2020 杨建祥. All rights reserved.
//

import UIKit
import ReactorKit

open class NormalCollectionItem: BaseCollectionItem, Reactor {
    
    public typealias Action = NoAction
    public typealias Mutation = NoMutation
    
    public struct State {
        var title = ""
//        var message = ""
//        var time = ""
//        var icon: UIImage?
//        var image: URL?
        public init(title: String = "") {
            self.title = title
        }
    }
    
    public var initialState = State()
    
    required public init(_ model: ModelType) {
        super.init(model)
//        guard let message = model as? Message else { return }
//        self.initialState = State(
//            title: message.title,
//            message: message.message,
//            time: message.time,
//            icon: message.icon,
//            image: message.image
//        )
    }
    
}
