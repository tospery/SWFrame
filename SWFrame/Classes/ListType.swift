//
//  ListType.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/14.
//

import UIKit
import ObjectMapper

public struct List<Item: ModelType>: ModelType {

    public var hasNext = false
    public var count = 0
    public var items = [Item].init()

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        if let compatible = self as? ListCompatible {
            hasNext = compatible.hasNext(map: map)
            count = compatible.count(map: map)
            items = compatible.items(map: map)
        } else {
            hasNext     <- map["has_next"]
            count       <- map["count"]
            items       <- map["items"]
        }
    }

}

public protocol ListCompatible {
    func hasNext(map: Map) -> Bool
    func count(map: Map) -> Int
    func items<Item: ModelType>(map: Map) -> [Item]
}

