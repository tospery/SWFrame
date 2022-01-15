//
//  ScrollViewController+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/15.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator
import DZNEmptyDataSet
import BonMot
import MJRefresh

public extension Reactive where Base: ScrollViewController {
    
    var loading: Binder<Bool> {
        return Binder(self.base) { viewController, isLoading in
            viewController.isLoading = isLoading
            guard viewController.isViewLoaded else { return }
            guard let scrollView = viewController.scrollView else { return }
            scrollView.reloadEmptyDataSet()
            if isLoading {
                if viewController.shouldLoadMore {
                    viewController.setupLoadMore(should: false)
                }
            } else {
                if viewController.shouldLoadMore {
                    viewController.setupLoadMore(should: true)
                }
                if viewController.noMoreData {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    scrollView.mj_footer?.resetNoMoreData()
                }
            }
        }
    }
    
    var refreshing: Binder<Bool> {
        return Binder(self.base) { viewController, isRefreshing in
            viewController.isRefreshing = isRefreshing
            guard viewController.isViewLoaded else { return }
            guard let scrollView = viewController.scrollView else { return }
            if !isRefreshing {
                scrollView.mj_header?.endRefreshing()
                if viewController.noMoreData {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    scrollView.mj_footer?.resetNoMoreData()
                }
            }
        }
    }
    
    var loadingMore: Binder<Bool> {
        return Binder(self.base) { viewController, isLoadingMore in
            viewController.isLoadingMore = isLoadingMore
            guard viewController.isViewLoaded else { return }
            guard let scrollView = viewController.scrollView else { return }
            if !isLoadingMore {
                if viewController.noMoreData {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                } else {
                    scrollView.mj_footer?.resetNoMoreData()
                }
            }
        }
    }
    
    var noMoreData: Binder<Bool> {
        return Binder(self.base) { viewController, noMoreData in
            viewController.noMoreData = noMoreData
//            guard viewController.isViewLoaded else { return }
//            guard let scrollView = viewController.scrollView else { return }
//            if noMoreData {
//                scrollView.mj_footer?.endRefreshingWithNoMoreData()
//            } else {
//                scrollView.mj_footer?.resetNoMoreData()
//            }
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
                scrollView.mj_header?.beginRefreshing()
            }
        }
    }
    
}

