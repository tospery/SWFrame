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
    
//    public func modelMember<Model: ModelType>(_ params: [String: Any]?, _ key: String, _ type: Model.Type) -> Model? {
//        guard let string = stringMember(params, key, nil) else { return nil }
//        guard let base64 = string.base64Decoded else { return nil }
//        guard let model = Model.init(JSONString: base64) else { return nil }
//        return model
//    }
    
    func model<Model: ModelType>(for key: String, type: Model.Type) -> Model? {
        guard let value = self[key] else { return nil }
        return (value as? Model) ?? UIColor.init(hexString: (value as? String) ?? "")
    }
    
}
