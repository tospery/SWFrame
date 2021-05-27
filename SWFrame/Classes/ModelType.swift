//
//  ModelType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

// MARK: - 模型协议
public protocol ModelType: Mappable, CustomStringConvertible {
    var isValid: Bool { get }
    init()
}

public extension ModelType {
    var isValid: Bool { true }
    
    var description: String {
        self.toJSONString() ?? ""
    }
}

public struct BaseModel: ModelType {
    
    public var data: Any?
    public var key: Any?
    public var value: Any?
    
    public var isValid: Bool {
        self.data != nil || self.key != nil || self.value != nil
    }
    
    public init() {
    }
    
    public init(_ data: Any?) {
        self.data = data
    }
    
    public init(key: Any?, value: Any?) {
        self.key = key
        self.value = value
    }
    
    public init?(map: Map) {
    }
    
    public mutating func mapping(map: Map) {
    }
    
}

//public struct ModelWrapper {
//
//    public var model: ModelType
//
//    public init(_ model: ModelType) {
//        self.model = model
//    }
//}

public struct ModelContext: MapContext {
    
    public let shouldMap: Bool
    
    public init(shouldMap: Bool = true){
        self.shouldMap = shouldMap
    }

}



