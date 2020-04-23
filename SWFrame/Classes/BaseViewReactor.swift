//
//  BaseViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit

open class BaseViewReactor: ReactorType {
    
    public let provider: ProviderType
    public let parameters: Dictionary<String, Any>
    public var title: String?
    
    required public init(_ provider: ProviderType, _ parameters: Dictionary<String, Any>?) {
        self.provider = provider
        self.parameters = parameters ?? [:]
        self.title = stringMember(parameters, Parameter.title, nil)
    }
    
}
