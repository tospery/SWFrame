//
//  BoolTransform.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/4/2.
//

import UIKit
import ObjectMapper
import SwifterSwift

public class BoolTransform: TransformType {

    public typealias Object = Bool
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Bool? {
        if let bool = value as? Bool {
            return bool
        } else if let int = value as? Int {
            return int.bool
        } else if let string = value as? String {
            return string.bool
        } else {
            return nil
        }
    }

    public func transformToJSON(_ value: Bool?) -> Any? {
        return value
    }
    
}
