//
//  ArrayExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension Array {
    
    var sortedJSONString: String {
        let temp = self
        var strings = [String].init()
        for value in temp {
            if let dictionary = value as? [String: Any] {
                strings.append(dictionary.sortedJSONString)
            } else if let array = value as? [Any] {
                strings.append(array.sortedJSONString)
            } else {
                strings.append("\"\(value)\"")
            }
        }
        strings.sort { $0 < $1 }
        var result = "["
        result += strings.joined(separator: ",")
        result += "]"
        return result
    }
    
    subscript (safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }
    
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
