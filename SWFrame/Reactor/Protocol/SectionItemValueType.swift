//
//  SectionItemValueType.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/24.
//

import Foundation

public protocol SectionItemValueType {
    var title: String? { get }
    var image: UIImage? { get }
    var urlScheme: String? { get }
}

extension SectionItemValueType {
    var title: String? { nil }
    var image: UIImage? { nil }
    var urlScheme: String? { nil }
}

