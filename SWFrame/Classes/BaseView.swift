//
//  BaseView.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/2.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

open class BaseView: UIView {
    
    public var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.theme.backgroundColor = themeService.attribute { $0.backgroundColor }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
