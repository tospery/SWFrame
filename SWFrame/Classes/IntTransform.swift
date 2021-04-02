//
//  IntTransform.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit
import QMUIKit
import ObjectMapper
import SwifterSwift

public class IntTransform: TransformType {

    public typealias Object = Int
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Int? {
        if let bool = value as? Bool {
            return bool.int
        } else if let int = value as? Int {
            return int
        } else if let string = value as? String {
            return string.int
        } else {
            return nil
        }
    }

    public func transformToJSON(_ value: Int?) -> Any? {
        return value
    }
    
}
