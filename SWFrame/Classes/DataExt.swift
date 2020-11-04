//
//  DataExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/23.
//

import UIKit

public extension Data {
    
    static func dataFromFile(withFilename filename: String, at bundleClass: AnyClass? = nil) -> Data? {
        let components = filename.components(separatedBy: ".")
        guard let name = components.first, let type = components.last else { return nil }
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main
        guard let path = bundle.path(forResource: name, ofType: type) else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    //    func jsonArray() -> Array<Any>? {
    //        if let data = self.data(using: .utf8),
    //            let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
    //            return object as? Array<Any>
    //        }
    //        return nil
    //    }
    
//    func jsonFromFile(
//        atPath path: String,
//        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
//
//        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
//
//        return json as? [String: Any]
//    }
    
}
