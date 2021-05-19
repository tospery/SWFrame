//
//  ScrollViewController+Rx.swift
//  SWFrame
//
//  Created by 杨建祥 on 2021/5/19.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import URLNavigator
import DZNEmptyDataSet
import BonMot
import ESPullToRefresh

public extension Reactive where Base: ScrollViewController {
    
    var loading: Binder<Bool> {
        return Binder(self.base) { viewController, isLoading in
            viewController.isLoading = isLoading
//            guard viewController.isViewLoaded else { return }
//            guard let scrollView = viewController.scrollView else { return }
//            if viewController.noMoreData {
//                scrollView.es.noticeNoMoreData()
//            } else {
//                scrollView.es.resetNoMoreData()
//            }
        }
    }
    
    var refreshing: Binder<Bool> {
        return Binder(self.base) { viewController, isRefreshing in
            viewController.isRefreshing = isRefreshing
            guard viewController.isViewLoaded else { return }
            if let scrollView = viewController.scrollView, !isRefreshing {
                scrollView.es.stopPullToRefresh()
            }
        }
    }
    
    var loadingMore: Binder<Bool> {
        return Binder(self.base) { viewController, isLoadingMore in
            viewController.isLoadingMore = isLoadingMore
            guard viewController.isViewLoaded else { return }
            if let scrollView = viewController.scrollView, !isLoadingMore {
                if !viewController.noMoreData {
                    scrollView.es.stopLoadingMore()
                } else {
                    scrollView.es.noticeNoMoreData()
                }
            }
        }
    }
    
    var noMoreData: Binder<Bool> {
        return Binder(self.base) { viewController, noMoreData in
            viewController.noMoreData = noMoreData
            guard viewController.isViewLoaded else { return }
            guard let scrollView = viewController.scrollView else { return }
            noMoreData ? scrollView.es.noticeNoMoreData() : scrollView.es.resetNoMoreData()
        }
    }
    
    var emptyDataSet: ControlEvent<Void> {
        let source = self.base.emptyDataSetSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var refresh: ControlEvent<Void> {
        let source = self.base.refreshSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var loadMore: ControlEvent<Void> {
        let source = self.base.loadMoreSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var startPullToRefresh: Binder<Void> {
        return Binder(self.base) { viewController, _ in
            if let scrollView = viewController.scrollView {
                scrollView.es.startPullToRefresh()
            }
        }
    }
    
}
