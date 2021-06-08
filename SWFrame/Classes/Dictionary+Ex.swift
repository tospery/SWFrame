//
//  Dictionary+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/6/9.
//

import Foundation
import SwifterSwift

public extension Dictionary where Key == String {
    
    func bool(for key: String) -> Bool? {
        guard let value = self[key] else { return nil }
        return (value as? Bool) ?? (value as? String)?.bool ?? (value as? Int)?.bool
    }
    
    func int(for key: String) -> Int? {
        guard let value = self[key] else { return nil }
        return (value as? Int) ?? (value as? String)?.int
    }
    
    func string(for key: String) -> String? {
        guard let value = self[key] else { return nil }
        return (value as? String) ?? (value as? Int)?.string
    }
    
    func url(for key: String) -> URL? {
        guard let value = self[key] else { return nil }
        return (value as? URL) ?? URL.init(string: (value as? String))
    }
    
    func color(for key: String) -> UIColor? {
        guard let value = self[key] else { return nil }
        return (value as? UIColor) ?? UIColor.init(hexString: (value as? String) ?? "")
    }
    
    func array(for key: String) -> [Any]? {
        guard let value = self[key] else { return nil }
        return value as? [Any]
    }
    
    func model<Model: ModelType>(for key: String, type: Model.Type) -> Model? {
        guard let value = self[key] else { return nil }
        if value is Model {
            return value as! Model
        }
        guard let string = self.string(for: key) else { return nil }
        guard let base64 = string.base64Decoded else { return nil }
        return Model.init(JSONString: base64)
    }
    
    func `enum`<T: RawRepresentable>(for key: String, type: T.Type) -> T? where T.RawValue == String {
        guard let value = self[key] else { return nil }
        if value is T {
            return value as! T
        }
        guard let string = self.string(for: key) else { return nil }
        return T.init(rawValue: string)
    }
    
    func `enum`<T: RawRepresentable>(for key: String, type: T.Type) -> T? where T.RawValue == Int {
        guard let value = self[key] else { return nil }
        if value is T {
            return value as! T
        }
        guard let int = self.int(for: key) else { return nil }
        return T.init(rawValue: int)
    }
    
}
