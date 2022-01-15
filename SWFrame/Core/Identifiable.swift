//
//  Identifiable.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

// MARK: - 标识协议
public protocol Identifiable {
    associatedtype Identity: Hashable
    var id: Identity { get }
}
