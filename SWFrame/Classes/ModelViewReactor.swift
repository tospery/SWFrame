//
//  ModelViewReactor.swift
//  SWFrame
//
//  Created by liaoya on 2020/8/5.
//

import UIKit

open class ModelViewReactor: ReactorType, WithModel, CustomStringConvertible {
    
    public var model: ModelType
    
    public required init(_ model: ModelType) {
        self.model = model
    }
    
    open var description: String {
        return self.model.description
    }
    
}
