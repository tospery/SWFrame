//
//  BaseTableHeaderFooterView.swift
//  SWFrame
//
//  Created by liaoya on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

open class BaseTableHeaderFooterView: UITableViewHeaderFooterView {
    
    public var disposeBag = DisposeBag()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.theme.backgroundColor = themeService.attribute { $0.backgroundColor }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    
}
