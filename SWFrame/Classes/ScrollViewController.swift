//
//  ScrollViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import URLNavigator
import DZNEmptyDataSet
import BonMot
import MJRefresh

open class ScrollViewController: BaseViewController {
    
    public let emptyDataSetSubject = PublishSubject<Void>()
    public let refreshSubject = PublishSubject<Void>()
    public let loadMoreSubject = PublishSubject<Void>()
    public var scrollView: UIScrollView!
    
    public var shouldRefresh = false
    public var shouldLoadMore = false
    
    public var isLoading = false
    public var isRefreshing = false
    public var isLoadingMore = false
    
    public var noMoreData = false
    
    // MARK: - Init
    public override init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        super.init(navigator, reactor)
        var scrollView: UIScrollView!
        if self is TableViewController {
            scrollView = UITableView(frame: .zero)
        } else if self is CollectionViewController {
            scrollView = UICollectionView(frame: .zero, collectionViewLayout: (self as! CollectionViewController).layout)
        } else {
            scrollView = UIScrollView(frame: .zero)
        }
        scrollView.backgroundColor = .white
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        self.scrollView = scrollView
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.scrollView.frame = self.contentFrame
        
        self.setupRefresh(should: self.shouldRefresh)
        self.setupLoadMore(should: self.shouldLoadMore)
        
        self.scrollView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        
        themeService.typeStream.skip(1)
            .observeOn(MainScheduler.instance)
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.scrollView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    // MARK: - Method
    open override func bind(reactor: BaseViewReactor) {
        super.bind(reactor: reactor)
    }
    
    @objc dynamic open func setupRefresh(should: Bool) {
        if should {
            self.scrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
                guard let `self` = self else { return }
                self.refreshSubject.onNext(())
            })
        } else {
            self.scrollView.mj_header?.removeFromSuperview()
            self.scrollView.mj_header = nil
        }
    }
    
    @objc dynamic open func setupLoadMore(should: Bool) {
        if should {
            self.scrollView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
                guard let `self` = self else { return }
                self.loadMoreSubject.onNext(())
            })
        } else {
            self.scrollView.mj_footer?.removeFromSuperview()
            self.scrollView.mj_footer = nil
        }
    }
    
    func handle(theme: ThemeType) {
        self.scrollView.reloadEmptyDataSet()
    }
    
}
