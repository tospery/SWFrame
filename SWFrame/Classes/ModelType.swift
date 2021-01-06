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

// MARK: - 私有变量
private var streams: [String: Any] = [:]
//private var storage: Storage = try! Storage(diskConfig: DiskConfig(name: "shared"), memoryConfig: MemoryConfig(), transformer: TransformerFactory.forCodable(ofType: String.self))

// MARK: - 标识协议
public protocol Identifiable {
    associatedtype Identity: Hashable
    var id: Identity { get }
}

// MARK: - 模型协议
public protocol ModelType: Mappable, CustomStringConvertible {
    init()
}

public extension ModelType {
    
    var description: String {
        return self.toJSONString() ?? "" // YJX_TODO Identifiable放在ModelType里
    }
    
}

public struct BaseModel: ModelType {
    
    public var value: Any?
    
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

// MARK: - 事件协议
public protocol Eventable {
    associatedtype Event
    static var event: PublishSubject<Event> { get }
}

public extension Eventable {
    static var event: PublishSubject<Event> {
        let key = String(fullname: self)
        if let stream = streams[key] as? PublishSubject<Event> {
            return stream
        }
        let stream = PublishSubject<Event>()
        streams[key] = stream
        return stream
    }
}

//open class BaseModel: Object, ModelType {
//
//    public required init() {
//
//    }
//
//    public required init?(map: Map) {
//
//    }
//
//    open func mapping(map: Map) {
//
//    }
//
//    open class var current: Self? {
//        return nil
//    }
//
//}

// MARK: - 存储协议
public protocol Storable: ModelType, Identifiable, Codable, Equatable {
    func save(ignoreId: Bool)

    static func objectKey(id: String?) -> String
    static func arrayKey(page: String?) -> String

    static func storeObject(_ object: Self?, id: String?)
    static func storeArray(_ array: [Self]?, page: String?)

    static func cachedObject(id: String?) -> Self?
    static func cachedArray(page: String?) -> [Self]?
    
    static func eraseObject(id: String?)
}

public extension Storable {

    func save(ignoreId: Bool = false) {
        type(of: self).storeObject(self, id: ignoreId ? nil : String(any: self.id))
    }

    static func objectKey(id: String? = nil) -> String {
        guard let id = id, !id.isEmpty else { return String(fullname: self) + "#object" }
        return String(fullname: self) + "#object#" + id
    }

    static func arrayKey(page: String? = nil) -> String {
        guard let page = page, !page.isEmpty else { return String(fullname: self) + "#array" }
        return String(fullname: self) + "#array#" + page
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

}


