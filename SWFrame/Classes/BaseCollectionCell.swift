//
//  BaseCollectionCell.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/10.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseCollectionCell: UICollectionViewCell {
    
    public var disposeBag = DisposeBag()
    public var model: ModelType?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
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
    
    open class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: metric(44))
    }
    
    open class func size(height: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: metric(100), height: height)
    }
    
}
