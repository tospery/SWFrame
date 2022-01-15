//
//  BundleExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension Bundle {
    
    convenience init?(module: String) {
        self.init(identifier: "org.cocoapods." + module)
    }
    
}
