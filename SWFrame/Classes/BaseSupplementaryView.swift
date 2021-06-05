//
//  BaseSupplementaryView.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

open class BaseSupplementaryView: UICollectionReusableView, Supplementary {
    
    public var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    // 不建议用bind，而应该在VC中进行单个属性的绑定
    open func bind(reactor: BaseSupplementaryReactor) {
    }
    
}


public protocol Supplementary {
    var kind: String { get }
}

public extension Supplementary {
    var kind: String {
        return UICollectionView.elementKindSectionHeader
    }
}

extension Reactive where Base: BaseSupplementaryView {
    
    public var reactor: Binder<BaseSupplementaryReactor> {
        return Binder(self.base) { view, reactor in
            view.bind(reactor: reactor)
        }
    }
    
}
