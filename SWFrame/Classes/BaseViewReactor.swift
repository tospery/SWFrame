//
//  BaseViewReactor.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa

open class BaseViewReactor: ReactorType {
    
    public let provider: ProviderType
    public var parameters: [String: Any]
    public var title: String?
    public var disposeBag = DisposeBag()
    
    required public init(_ provider: ProviderType, _ parameters: [String: Any]?) {
        self.provider = provider
        self.parameters = parameters ?? [:]
        self.title = self.parameters[Parameter.title] as? String ?? nil
    }
    
}
