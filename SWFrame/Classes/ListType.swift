//
//  ListType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/14.
//

import UIKit
import ObjectMapper

public protocol ListType: ModelType {
    associatedtype Item: ModelType
    
    var hasNext: Bool { get }
    var count: Int { get }
    var items: [Item]? { get }
    
}
