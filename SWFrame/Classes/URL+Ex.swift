//
//  URL+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/22.
//

import Foundation
import URLNavigator
import SwifterSwift

public extension URL {
    
    func insertingPathComponent(_ pathComponent: String, at index: UInt) -> URL {
        guard let scheme = self.scheme else { return self }
        guard let host = self.host else { return self }
        let path = self.path.removingPrefix("/").removingSuffix("/")
        if path.isEmpty && index > 0 {
            return self
        }
        let paths = path.components(separatedBy: "/")
        if index > paths.count {
            return self
        }
        var pathString = ""
        for (idx, val) in paths.enumerated() {
            if idx == index {
                pathString += "/\(pathComponent)/\(val)"
            } else {
                pathString += "/\(val)"
            }
        }
        let urlString = "\(scheme)://\(host)\(pathString)"
        guard var result = urlString.url else { return self }
        if let queries = self.queryParameters,
           queries.count != 0 {
            result.appendQueryParameters(queries)
        }
        return result
    }
    
    mutating func insertPathComponent(_ pathComponent: String, at index: UInt) {
        self = insertingPathComponent(pathComponent, at: index)
    }
    
}
