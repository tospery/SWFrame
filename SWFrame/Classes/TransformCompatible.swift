//
//  TransformCompatible.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/29.
//

import Foundation

public protocol TransformCompatible {
    func toString(_ value: Any?) -> String?
}

extension TransformCompatible {
    func toString(_ value: Any?) -> String? { nil }
}
