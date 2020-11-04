//
//  ArrayExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/23.
//

import UIKit

public extension Array {
    
//    func jsonString(prettyPrinted: Bool = true) -> String? {
//        if let data = try? JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? .prettyPrinted : []) {
//            return String(data: data, encoding: .utf8)
//        }
//        return nil
//    }
    
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
}
