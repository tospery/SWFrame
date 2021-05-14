//
//  ModelType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit
import RxSwift
import RxCocoa
//import RealmSwift
import ObjectMapper

//private var storage: Storage = try! Storage(diskConfig: DiskConfig(name: "shared"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: String.self))

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
    
    public var value: Any?
    
    public var isValid: Bool { self.value != nil }
    
    public init() {
    }
    
    public init(_ data: Any?) {
        self.value = data
    }
    
    public init?(map: Map) {
    }
    
    public mutating func mapping(map: Map) {
    }
    
}

public struct ModelContext: MapContext {
    
    public let shouldMap: Bool
    
    public init(shouldMap: Bool = true){
        self.shouldMap = shouldMap
    }

}



