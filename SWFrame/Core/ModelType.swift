//
//  ModelType.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import ObjectMapper_JX
import SwifterSwift

// MARK: - 模型协议
public protocol ModelType: Mappable, CustomStringConvertible {
    var uuid: String { get }
    var isValid: Bool { get }
    init()
}

public extension ModelType {
    var uuid: String { UUID.init().uuidString }
    var isValid: Bool { true }
    var description: String { self.toJSON().sortedJSONString }
}

public struct BaseModel: ModelType {

    public var data: Any?
    
    public var isValid: Bool { self.data != nil }
    
    public init() {
    }
    
    public init(_ data: Any?) {
        self.data = data
    }
    
    public init?(map: Map) {
    }
    
    public mutating func mapping(map: Map) {
        data    <- map["data"]
    }
    
    public var description: String {
        String.init(describing: self.data)
    }

}

public struct ModelContext: MapContext {
    
    public let shouldMap: Bool
    
    public init(shouldMap: Bool = true){
        self.shouldMap = shouldMap
    }

}

