//
//  DynamicTarget.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/8/22.
//

import UIKit
import Moya

public struct DynamicTarget: TargetType {
    public let baseURL: URL
    public let target: TargetType
    
    public var path: String { target.path }
    public var method: Moya.Method { target.method }
    public var sampleData: Data { target.sampleData }
    public var task: Task { target.task }
    public var validationType: ValidationType { target.validationType }
    public var headers: [String: String]? { target.headers }
    
    public init(baseURL: URL, target: TargetType) {
        self.baseURL = baseURL
        self.target = target
    }
}
