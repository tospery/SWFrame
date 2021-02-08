//
//  TargetTypeExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/12/12.
//

import Moya

public extension TargetType {

    var samplePath: String? {
        var path = self.path.replacingOccurrences(of: "/", with: "-")
        if path.hasPrefix("-") {
            path.removeFirst()
        }
        return path
    }

}
