//
//  UICollectionViewExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/10.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import RxDataSources

public extension UICollectionView {

    func sectionWidth(at section: Int) -> CGFloat {
        var width = self.width
        width -= self.contentInset.left
        width -= self.contentInset.right

        if let delegate = self.delegate as? UICollectionViewDelegateFlowLayout,
            let inset = delegate.collectionView?(self, layout: self.collectionViewLayout, insetForSectionAt: section) {
            width -= inset.left
            width -= inset.right
        } else if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            width -= layout.sectionInset.left
            width -= layout.sectionInset.right
        }

        return width
    }
    
    func sectionHeight(at section: Int) -> CGFloat {
        var height = self.height
        height -= self.contentInset.top
        height -= self.contentInset.bottom
        
        if let delegate = self.delegate as? UICollectionViewDelegateFlowLayout,
            let inset = delegate.collectionView?(self, layout: self.collectionViewLayout, insetForSectionAt: section) {
            height -= inset.top
            height -= inset.bottom
        } else if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            height -= layout.sectionInset.top
            height -= layout.sectionInset.bottom
        }
        
        return height
    }
    
    func emptyCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "iOSFrame.UICollectionView.emptyCell"
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.isHidden = true
        return cell
    }

    func emptyView(for indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        let identifier = "iOSFrame.UICollectionView.emptyView"
        self.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.isHidden = true
        return view
    }

}

public extension Reactive where Base: UICollectionView {
    
    func itemSelected<Section>(dataSource: CollectionViewSectionedDataSource<Section>) -> ControlEvent<Section.Item> {
        let source = self.itemSelected.map { indexPath in
            dataSource[indexPath]
        }
        return ControlEvent(events: source)
    }
    
}
