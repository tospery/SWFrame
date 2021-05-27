//
//  PortalType.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/24.
//

import Foundation

public protocol PortalType {
    var title: String? { get }
    var image: UIImage? { get }
    var urlScheme: String? { get }
}

extension PortalType {
    var title: String? { nil }
    var image: UIImage? { nil }
    var urlScheme: String? { nil }
}

