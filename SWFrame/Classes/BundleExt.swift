//
//  BundleExt.swift
//  Alamofire
//
//  Created by 杨建祥 on 2020/4/8.
//

import UIKit

public extension Bundle {
    
    convenience init?(module: String) {
        self.init(identifier: "org.cocoapods." + module)
    }
    
}
