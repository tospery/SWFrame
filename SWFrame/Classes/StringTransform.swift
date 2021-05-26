//
//  StringTransform.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit
import ObjectMapper
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
            return nil
        }
    }

    public func transformToJSON(_ value: String?) -> Any? {
        return value
    }
    
}
