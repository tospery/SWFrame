//
//  ReactorType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit

public protocol ReactorType {
    
}

public protocol WithModel {
    var model: ModelType { get set }
    init(_ model: ModelType)
}
