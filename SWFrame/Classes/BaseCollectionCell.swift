//
//  BaseCollectionCell.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/10.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseCollectionCell: UICollectionViewCell {
    
    public var disposeBag = DisposeBag()
    public var model: ModelType?
    public var father: BaseViewReactor?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.contentView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    // MARK: - Public
    open func bind(item: BaseCollectionItem) {
        self.model = item.model
    }
    
    open func inject(father: BaseViewReactor) {
        self.father = father
    }
    
    open class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: metric(44))
    }
    
    open class func size(height: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: metric(100), height: height)
    }
    
}
