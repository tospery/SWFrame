//
//  BaseSupplementaryView.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseSupplementaryView: UICollectionReusableView, Supplementary {
    
    public var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    public func bind(reactor: BaseSupplementaryReactor) {
        
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
