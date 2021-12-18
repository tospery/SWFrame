//
//  BaseTableCell.swift
//  SWFrame
//
//  Created by liaoya on 2020/8/17.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

open class BaseTableCell: UITableViewCell {
    
    public var disposeBag = DisposeBag()
    public var model: ModelType?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.theme.backgroundColor = themeService.attribute { $0.backgroundColor }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    // MARK: - Public
    open func bind(item: BaseTableItem) {
        self.model = item.model
    }
    
    open class func height(item: BaseTableItem) -> CGFloat {
        44
    }
    
}

