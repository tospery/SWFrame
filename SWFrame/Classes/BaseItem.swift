//
//  BaseItem.swift
//  Alamofire
//
//  Created by 杨建祥 on 2020/4/10.
//

import UIKit

open class BaseItem: ReactorType {

    let model: ModelType
    
    required public init(_ model: ModelType) {
        self.model = model
    }
    
}
