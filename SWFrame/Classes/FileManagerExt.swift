//
//  FileManagerExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/23.
//

import UIKit

public extension FileManager {
    
    func json(withFilename filename: String, at bundleClass: AnyClass? = nil) -> Any? {
        guard let data = self.data(withFilename: filename, at: bundleClass) else { return nil }
        return try? JSONSerialization.jsonObject(with: data)
    }
    
    func data(withFilename filename: String, at bundleClass: AnyClass? = nil) -> Data? {
        let components = filename.components(separatedBy: ".")
        guard let name = components.first, let type = components.last else { return nil }
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main
        guard let path = bundle.path(forResource: name, ofType: type) else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    
}
