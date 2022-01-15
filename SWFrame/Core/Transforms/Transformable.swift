//
//  Transformable.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public protocol Transformable {
    func toString(_ value: Any?) -> String?
}

extension Transformable {
    func toString(_ value: Any?) -> String? { nil }
}
