//
//  TargetTypeExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/12/12.
//

import Moya

public extension TargetType {

//    var samplePath: String? {
//        var path = self.path.replacingOccurrences(of: "/", with: "-")
//        if path.hasPrefix("-") {
//            path.removeFirst()
//        }
//        return path
//    }
    
    var sampleData: Data {
        var name = self.path.replacingOccurrences(of: "/", with: "-")
        if name.hasPrefix("-") {
            name.removeFirst()
        }
        guard let url = Bundle.main.url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return .init()
        }
        return data
    }

}
