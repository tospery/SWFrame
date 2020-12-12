//
//  TargetTypeExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/12/12.
//

import Moya

public extension TargetType {

    var samplePath: URL? {
        var name = self.path.replacingOccurrences(of: "/", with: "-")
        if name.hasPrefix("-") {
            name = String.init(name[name.index(after: name.startIndex)...])
        }
        return Bundle.main.url(forResource: name, withExtension: "json")
    }
    
}
