//
//  BaseViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseViewReactor: NSObject, ReactorType {
    
    public let host: Router.Host
    public let path: Router.Path?
    public let provider: ProviderType
    public var parameters: [String: Any]
    public var title: String?
    public var disposeBag = DisposeBag()
    
    required public init(_ provider: ProviderType, _ parameters: [String: Any]?) {
        self.host = parameters?.string(for: Parameter.host) ?? .user
        self.path = parameters?.string(for: Parameter.path)
        self.provider = provider
        self.parameters = parameters ?? [:]
        self.title = self.parameters.string(for: Parameter.title)
    }
    
    deinit {
        #if DEBUG
        logger.print("\(self.className)已销毁！！！", module: .swframe)
        #endif
    }
    
}
