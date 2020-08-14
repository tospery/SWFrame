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
    
    // var id: String { get }
}

//public extension Identifiable {
//    var id: String {
//        get {
//            id
//        }
//        set {
//            id = newValue
//        }
//    }
//}

// MARK: - 模型协议
public protocol ModelType: Mappable, CustomStringConvertible {
    init()
}

public extension ModelType {
    
    public var description: String {
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

// MARK: - 事件协议
public protocol Eventable {
    associatedtype Event
    static var event: PublishSubject<Event> { get }
}

public extension Eventable {
    static var event: PublishSubject<Event> {
        let key = String(describing: self)
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
    static func arrayKey(page: Int?) -> String

    static func storeObject(_ object: Self?, id: String?)
    static func storeArray(_ array: [Self]?, page: Int?)

    static func cachedObject(id: String?) -> Self?
    static func cachedArray(page: Int?) -> [Self]?
    
    static func eraseObject(id: String?)
}

public extension Storable {

    func save(ignoreId: Bool = false) {
        type(of: self).storeObject(self, id: ignoreId ? nil : String(any: self.id))
    }

    static func objectKey(id: String? = nil) -> String {
        guard let id = id, !id.isEmpty else { return String(describing: self) + "#object" }
        return String(describing: self) + "#object#" + id
    }

    static func arrayKey(page: Int? = nil) -> String {
        guard let page = page?.string, !page.isEmpty else { return String(describing: self) + "#array" }
        return String(describing: self) + "#array#" + page
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

}

//public extension Storable2 {
//
//    func save(ignoreKey: Bool = false) {
//        type(of: self).storeObject(self, id: ignoreKey ? nil : String(any: self.id))
//    }
//
//    static func arrayStoreKey() -> String {
//        return String(describing: self) + "#array"
//    }
//
//    static func objectStoreKey(id: String? = nil) -> String {
//        guard let id = id else { return String(describing: self) + "#object" }
//        return String(describing: self) + "#object#" + id
//    }
//
//    static func storeObject(_ object: Self, id: String? = nil) {
//        let key = self.objectStoreKey(id: id)
//        try? storage.transformCodable(ofType: self).setObject(object, forKey: key)
//    }
//
//    static func storeArray(_ array: Array<Self>) {
//        let key = self.arrayStoreKey()
//        try? storage.transformCodable(ofType: Array<Self>.self).setObject(array, forKey: key)
//    }
//
//    static func cachedObject(id: String? = nil) -> Self? {
//        let key = self.objectStoreKey(id: id)
//        if let object = try? storage.transformCodable(ofType: self).object(forKey: key) {
//            return object
//        }
//
//        if let path = Bundle.main.path(forResource: key, ofType: "json"),
//            let json = try? String(contentsOfFile: path, encoding: .utf8) {
//            return Self(JSONString: json)
//        }
//
//        return nil
//    }
//
//    static func cachedArray() -> Array<Self>? {
//        let key = self.arrayStoreKey()
//        if let array = try? storage.transformCodable(ofType: Array<Self>.self).object(forKey: key) {
//            return array
//        }
//
//        if let path = Bundle.main.path(forResource: key, ofType: "json"),
//            let json = try? String(contentsOfFile: path, encoding: .utf8) {
//            return Array<Self>(JSONString: json)
//        }
//
//        return nil
//    }
//
//    static func eraseObject(id: String? = nil) {
//        let key = self.objectStoreKey(id: id)
//        try? storage.removeObject(forKey: key)
//    }
//
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.id == rhs.id
//    }
//}

// MARK: - 流协议
//public protocol Subjective {
//    var subject: BehaviorRelay<ModelType?> { get }
//}
//
//public extension Subjective {
//
//    var subject: BehaviorRelay<ModelType?> {
//        return BehaviorRelay<ModelType?>(value: nil)
//    }
//
//}

//public protocol Subjective2: Storable2 {
//    static func subject() -> BehaviorRelay<Self?>
//    static func current() -> Self?
//    static func update(_ value: Self?, _ toCache: Bool)
//}
//
//public extension Subjective2 {
//    static func subject() -> BehaviorRelay<Self?> {
//        let key = String(describing: self)
//        if let subject = subjects2[key] as? BehaviorRelay<Self?> {
//            return subject
//        }
//        let subject = BehaviorRelay<Self?>(value: Self.cachedObject())
//        subjects2[key] = subject
//        return subject
//    }
//
//    static func current() -> Self? {
//        self.subject().value
//    }
//
//    static func update(_ value: Self?, _ toCache: Bool = true) {
//        let subject = self.subject()
//        guard let value = value else {
//            if toCache {
//                Self.eraseObject()
//            }
//            subject.accept(nil)
//            return
//        }
//
//        if toCache {
//            Self.storeObject(value)
//        }
//        subject.accept(value)
//    }
//
//}

