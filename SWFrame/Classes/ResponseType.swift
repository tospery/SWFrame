//
//  ResponseType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/8/19.
//

import UIKit
import RxSwift
import Moya
import Alamofire
import ObjectMapper

public let successCode = 200

public protocol ResponseType {
    var code: Int { get }
    var message: String { get }
    var data: Any? { get }
    var json: [String: Any] { get }
}

public protocol ResponseCompatible {
    func code(map: Map) -> Int
    func message(map: Map) -> String
    func data(map: Map) -> Any?
    
    func code(_ target: TargetType) -> Int
    func message(_ target: TargetType) -> String
    func data(_ target: TargetType) -> Any?
}

public struct BaseResponse: ResponseType, ModelType {
    public var code = 0
    public var message = ""
    public var data: Any?
    public var json = [String: Any].init()
    
    public init() {
    }
    
    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        if let compatible = self as? ResponseCompatible {
            code = compatible.code(map: map)
            message = compatible.message(map: map)
            data = compatible.data(map: map)
        } else {
            code        <- map["code"]
            message     <- map["message"]
            data        <- map["data"]
        }
        json = map.JSON
    }
    
    func code(_ target: TargetType) -> Int {
        if let compatible = self as? ResponseCompatible {
            return compatible.code(target)
        } else {
            return self.code
        }
    }
    
    func message(_ target: TargetType) -> String {
        if let compatible = self as? ResponseCompatible {
            return compatible.message(target)
        } else {
            return self.message
        }
    }
    
    func data(_ target: TargetType) -> Any? {
        if let compatible = self as? ResponseCompatible {
            return compatible.data(target)
        } else {
            return self.data
        }
    }
}
