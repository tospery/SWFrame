//
//  StringRawRepresentable.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/31.
//

import Foundation
import SwifterSwift

public protocol StringRawRepresentable {
    var stringRawValue: String { get }
}

extension StringRawRepresentable where Self: RawRepresentable, Self.RawValue == String {
    var stringRawValue: String { return self.rawValue }
}

extension StringRawRepresentable where Self: RawRepresentable, Self.RawValue == Int {
    var stringRawValue: String { return self.rawValue.string }
}
