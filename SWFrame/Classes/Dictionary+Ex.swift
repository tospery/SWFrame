//
//  Dictionary+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/6/9.
//

import Foundation
import SwifterSwift

public extension Dictionary where Key == String {
    
    
    func model<Model: ModelType>(for key: String, type: Model.Type) -> Model? {
        guard let value = self[key] else { return nil }
        if value is Model {
            return value as! Model
        }
        guard let string = self.string(for: key) else { return nil }
        guard let base64 = string.base64Decoded else { return nil }
        return Model.init(JSONString: base64)
    }
    
}
