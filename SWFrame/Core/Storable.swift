//
//  Storable.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

// MARK: - 存储协议
public protocol Storable: ModelType, Identifiable, Codable, Equatable {
    
    // associatedtype Base: Storable where Base.Base == Base
    // associatedtype Store: Storable
    
    static func objectKey(id: String?) -> String
    static func arrayKey(page: String?) -> String

    static func storeObject(_ object: Self?, id: String?)
    static func storeArray(_ array: [Self]?, page: String?)

    static func cachedObject(id: String?) -> Self?
    static func cachedArray(page: String?) -> [Self]?

    static func eraseObject(id: String?)
}

public extension Storable {

    static func objectKey(id: String? = nil) -> String {
        var key = String(fullname: self)
        if let path = id {
            key += "#\(path)"
        }
        return key
    }

    static func arrayKey(page: String? = nil) -> String {
        var key = "\(String(fullname: self))s"
        if let path = page {
            key += "#\(path)"
        }
        return key
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.description.sorted() == rhs.description.sorted()
    }

}

