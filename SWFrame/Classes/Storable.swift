//
//  Storable.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/14.
//

import Foundation

// MARK: - 存储协议
public protocol Storable: ModelType, Identifiable, Codable, Equatable {
    //func save(ignoreId: Bool)
    // associatedtype Base: Storable where Base.Base == Base
    // associatedtype Store: Storable
    
    static func objectKey(id: String?) -> String
    static func arrayKey(page: String?) -> String

    static func storeObject(_ object: Self?, id: String?)
    // static func storeArray(_ array: [Base]?, page: String?)

    static func cachedObject(id: String?) -> Self?
    // static func cachedArray(page: String?) -> [Base]?

    static func eraseObject(id: String?)
}

public extension Storable {

//    func save(ignoreId: Bool = false) {
//        type(of: self).storeObject(self, id: ignoreId ? nil : String(any: self.id))
//    }

    static func objectKey(id: String? = nil) -> String {
        "\(String(fullname: self))\(id ?? "")"
    }

    static func arrayKey(page: String? = nil) -> String {
        "\(String(fullname: self))s\(page ?? "")"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

}
