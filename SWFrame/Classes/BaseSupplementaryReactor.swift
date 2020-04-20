//
//  BaseSupplementaryReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit

open class BaseSupplementaryReactor: ReactorType, WithModel {
    
    public var model: ModelType
    
    public required init(_ model: ModelType) {
        self.model = model
    }
    
}
