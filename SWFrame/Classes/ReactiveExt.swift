//
//  ReactiveExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import QMUIKit
import Toast_Swift
import ESPullToRefresh
import Kingfisher

// MARK: - UIView
public extension Reactive where Base: UIView {
    
//    var loading: Binder<Bool> {
//        return Binder(self.base) { view, loading in
//            view.isUserInteractionEnabled = !loading
//            loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//        }
//    }
    
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
    
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.qmui_borderColor = attr
        }
    }
    
}

public extension Reactive where Base: UIImageView {
    func image(placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
        return Binder(self.base) { imageView, resource in
            imageView.kf.setImage(with: resource, placeholder: placeholder, options: options)
        }
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

//public extension Reactive where Base: UIViewController {
//
//    var loading: Binder<Bool> {
//        return Binder(self.base) { viewController, loading in
//            if viewController.qmui_isViewLoadedAndVisible() {
//                let view = viewController.view!
//                view.isUserInteractionEnabled = !loading
//                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//            }
//        }
//    }
//
//}

// MARK: - BaseViewController
public extension Reactive where Base: BaseViewController {
    
    var loading: Binder<Bool> {
        return Binder(self.base) { viewController, loading in
            viewController.loading = loading
//            if viewController.qmui_isViewLoadedAndVisible() {
//                let view = viewController.view!
//                view.isUserInteractionEnabled = !loading
//                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//            }
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
        }
    }
    
//    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
//        return Binder(self.base) { viewController, attr in
//            viewController.emptyDataSetImageTintColor.accept(attr)
//        }
//    }
    
//    var emptyDataSetTap: ControlEvent<Void> {
//        let source = self.base.emptyDataSetSubject.map{ _ in }
//        return ControlEvent(events: source)
//    }
    
}

// MARK: - ScrollViewController
public extension Reactive where Base: ScrollViewController {
    
    var noMoreData: Binder<Bool> {
        return Binder(self.base) { viewController, noMoreData in
            viewController.noMoreData = noMoreData
        }
    }
    
    var emptyDataSet: ControlEvent<Void> {
        let source = self.base.emptyDataSetSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
//    var shouldRefresh: Binder<Bool> {
//        return Binder(self.base) { viewController, shouldRefresh in
//            viewController.setupRefresh(should: shouldRefresh)
//        }
//    }
//    
//    var shouldLoadMore: Binder<Bool> {
//        return Binder(self.base) { viewController, shouldLoadMore in
//            viewController.setupLoadMore(should: shouldLoadMore)
//        }
//    }
    
    var isRefreshing: Binder<Bool> {
        return Binder(self.base) { viewController, isRefreshing in
            if let scrollView = viewController.scrollView, !isRefreshing {
                scrollView.es.stopPullToRefresh()
            }
        }
    }
    
    var isLoadingMore: Binder<Bool> {
        return Binder(self.base) { viewController, isLoadingMore in
            if let scrollView = viewController.scrollView, !isLoadingMore {
                if !viewController.noMoreData {
                    scrollView.es.stopLoadingMore()
                } else {
                    scrollView.es.noticeNoMoreData()
                }
            }
        }
    }
    
    var refresh: ControlEvent<Void> {
        let source = self.base.refreshSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var loadMore: ControlEvent<Void> {
        let source = self.base.loadMoreSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
}
