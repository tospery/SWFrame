//
//  Case.swift
//  SWFrame
//
//  Created by liaoya on 2020/7/7.
//

import UIKit
import ObjectMapper
import RxDataSources

public struct Case: Mappable {
    var name = ""
    var forward = ""
    var parameters: Dictionary<String, Any>?
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        name        <- map["name"]
        forward     <- map["forward"]
        parameters  <- map["parameters"]
    }
}

public struct CaseSection {
    public var items: [Item]
}

extension CaseSection : SectionModelType {
    public typealias Item = Case

    public init(original: CaseSection, items: [Item]) {
        self = original
        self.items = items
    }
}
