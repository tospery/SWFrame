//
//  BaseViewReactor.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/5.
//

import UIKit

open class BaseViewReactor: ReactorType {
    
//    self.hidesNavigationBar = BZMBoolMember(parameters, BZMParameter.hideNavBar, NO);
//    self.hidesNavBottomLine = BZMBoolMember(parameters, BZMParameter.hideNavLine, NO);
    
    public let provider: ProviderType
    public let parameters: Dictionary<String, Any>?
    public var title: String?
    public var hidesNavigationBar = false
    public var hidesNavBottomLine = false
    
//    // public let provider = Provider.default
//    public let provider: ProviderType
//
//    public var title: String?
//
//    // let provider: ServiceProviderType
//    public weak var viewController : BaseViewController!
//
    
    required public init(_ provider: ProviderType, _ parameters: Dictionary<String, Any>?) {
        self.provider = provider
        self.parameters = parameters
//        self.provider = provider
//        self.params = params ?? [:]
//        self.title = stringMember(self.params, Constant.Parameter.title, nil)
//        self.keyword = stringMember(self.params, Constant.Parameter.keyword, nil)
//        self.statusBarStyle = intMember(self.params, Constant.Parameter.statusBarStyle, themeService.attrs.statusBarStyle.rawValue) == 0 ? .default: .lightContent
//        // self.backgroundColor = self.params[Constant.ViewModel.backgroundColor] as? UIColor ?? themeService.attrs.primaryDark
        self.title = stringMember(parameters, Parameter.title, nil)
        self.hidesNavigationBar = boolMember(parameters, Parameter.hideNavBar, false)
        self.hidesNavBottomLine = boolMember(parameters, Parameter.hideNavLine, false)
    }
    
}
