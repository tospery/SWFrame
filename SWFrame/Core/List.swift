//
//  List.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import ObjectMapper_JX

public struct List<Item: ModelType>: ModelType {

    public var id = 0
    public var hasNext = false
    public var count = 0
    public var items = [Item].init()

    public init() {
    }

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        if let compatible = self as? ListCompatible {
            count = compatible.count(map: map)
            items = compatible.items(map: map)
            hasNext = compatible.hasNext(map: map)
        } else {
            items       <- map["items"]
            count       <- map["count"]
            hasNext     <- map["has_next"]
        }
    }

}

public protocol ListCompatible {
    func hasNext(map: Map) -> Bool
    func count(map: Map) -> Int
    func items<Item: ModelType>(map: Map) -> [Item]
}

extension ListCompatible {
    public func hasNext(map: Map) -> Bool {
        var hasNext: Bool?
        hasNext   <- map["has_next"]
        return hasNext ?? false
    }
    
    public func count(map: Map) -> Int {
        var count: Int?
        count   <- map["count"]
        return count ?? 0
    }

    public func items<Item>(map: Map) -> [Item] where Item: ModelType {
        var items: [Item]?
        items         <- map["items"]
        return items ?? []
    }
}
