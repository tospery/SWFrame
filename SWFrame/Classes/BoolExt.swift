//
//  BoolExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/9.
//

import UIKit

public protocol BooleanType {
    var boolValue: Bool { get }
}

extension Bool: BooleanType {
    public var boolValue: Bool { return self }
}

