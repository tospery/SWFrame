//
//  BaseCollectionReusableView.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

open class BaseCollectionReusableView: UICollectionReusableView, Supplementary {
    
    public var disposeBag = DisposeBag()
    // public var model: ModelType?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.theme.backgroundColor = themeService.attribute { $0.backgroundColor }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    open func bind(reactor: BaseViewReactor) {
        // self.model = reactor.model
    }
     
}


public protocol Supplementary {
    var kind: String { get }
}

public extension Supplementary {
    var kind: String { UICollectionView.elementKindSectionHeader }
}

//extension Reactive where Base: BaseCollectionReusableView {
//    
//    public var reactor: Binder<BaseSupplementaryReactor> {
//        return Binder(self.base) { view, reactor in
//            view.bind(reactor: reactor)
//        }
//    }
//    
//}
