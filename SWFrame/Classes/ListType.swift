//
//  ListType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/14.
//

import UIKit
import ObjectMapper

public struct List<Item: ModelType>: ModelType {

    public var hasNext = false
    public var count = 0
    public var items: [Item]?

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        hasNext     <- map["has_next"]
        count       <- map["count"]
        items       <- map["items"]
        if items == nil {
            items       <- map["objects"]
        }
        if items == nil {
            items       <- map["messages"]
        }
    }

}

