//
//  CollectionFooterView.swift
//  SWFrame.default-Components_JSBridge
//
//  Created by liaoya on 2022/3/9.
//

import UIKit

open class CollectionFooterView: BaseCollectionReusableView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var kind: String { UICollectionView.elementKindSectionFooter }
    
}
