//
//  StringTransform.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import ObjectMapper_JX
import SwifterSwift

public class StringTransform: TransformType {

    public typealias Object = String
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> String? {
        if let bool = value as? Bool {
            return bool.string
        } else if let int = value as? Int {
            return int.string
        } else if let string = value as? String {
            return string
        } else {
            if let compatible = self as? Transformable {
                return compatible.toString(value)
            }
            return nil
        }
    }

    public func transformToJSON(_ value: String?) -> Any? {
        return value
    }
    
}
