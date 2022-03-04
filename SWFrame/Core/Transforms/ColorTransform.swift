//
//  ColorTransform.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit
import ObjectMapper_JX
import SwifterSwift

public class ColorTransform: TransformType {

    public typealias Object = UIColor
    public typealias JSON = Any
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> UIColor? {
        if let int = value as? Int,
           let color =  UIColor.init(hex: int) {
            return color
        }
        if let string = value as? String,
           let color = UIColor.init(hexString: string) {
            return color
        }
        return nil
    }

    public func transformToJSON(_ value: UIColor?) -> Any? {
        value?.hexString
    }
    
}
