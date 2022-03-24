//
//  DictionaryExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import SwifterSwift
import SwiftUI

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
    
    func data(for key: String) -> Data? {
        guard let value = self[key] else { return nil }
        return value as? Data
    }

    func url(for key: String) -> URL? {
        guard let value = self[key] else { return nil }
        //return (value as? URL) ?? URL.init(string: (value as? String))
        if let url = value as? URL {
            return url
        }
        if let string = value as? String {
            if let url = URL.init(string: string) {
                return url
            }
            if let url = URL.init(string: string.urlEncoded) {
                return url
            }
            if let url = URL.init(string: string.urlDecoded) {
                return url
            }
        }
        return nil
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
            return value as? Model
        }
        guard let string = self.string(for: key) else { return nil }
        guard let base64 = string.base64Decoded else { return nil }
        return Model.init(JSONString: base64)
    }

    func `enum`<T: RawRepresentable>(for key: String, type: T.Type) -> T? where T.RawValue == String {
        guard let value = self[key] else { return nil }
        if value is T {
            return value as? T
        }
        guard let string = self.string(for: key) else { return nil }
        return T.init(rawValue: string)
    }

    func `enum`<T: RawRepresentable>(for key: String, type: T.Type) -> T? where T.RawValue == Int {
        guard let value = self[key] else { return nil }
        if value is T {
            return value as? T
        }
        guard let int = self.int(for: key) else { return nil }
        return T.init(rawValue: int)
    }

    var toStringString: [String: String] {
        var result = [String: String].init()
        for key in self.keys {
            let value = self[key]!
            result[key] = String.init(describing: value)
        }
        return result
    }

    var sortedJSONString: String {
        var temp = self
        var keys = [String].init()
        for key in temp.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var strings = [String].init()
        for key in keys {
            if let value = temp[key] as? [String: Any] {
                strings.append("\"\(key)\":\(value.sortedJSONString)")
            } else if let value = temp[key] as? [Any] {
                strings.append("\"\(key)\":\(value.sortedJSONString)")
            } else {
                strings.append("\"\(key)\":\"\(temp[key]!)\"")
            }
        }
        var result = "{"
        result += strings.joined(separator: ",")
        result += "}"
        return result
    }

}
