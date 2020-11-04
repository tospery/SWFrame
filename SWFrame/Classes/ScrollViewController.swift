//
//  ScrollViewController.swift
//  iOSFrame
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
import ESPullToRefresh

open class ScrollViewController: BaseViewController {
    
    public let emptyDataSetSubject = PublishSubject<Void>()
    public let refreshSubject = PublishSubject<Void>()
    public let loadMoreSubject = PublishSubject<Void>()
    public var scrollView: UIScrollView!
    public var noMoreData = false
    
    public var shouldRefresh = false
    public var shouldLoadMore = false
    
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
    }
    
    // MARK: - Method
    open override func bind(reactor: BaseViewReactor) {
        super.bind(reactor: reactor)
    }
    
    open func setupRefresh(should: Bool) {
        if should {
            let animator = ESRefreshHeaderAnimator.init(frame: .zero)
            self.scrollView.es.addPullToRefresh(animator: animator) { [weak self] in
                guard let `self` = self else { return }
                self.refreshSubject.onNext(())
            }
            self.scrollView.refreshIdentifier = "Refresh"
            self.scrollView.expiredTimeInterval = 30.0
        } else {
            self.scrollView.es.removeRefreshHeader()
        }
    }
    
    open func setupLoadMore(should: Bool) {
        if should {
            let animator = ESRefreshFooterAnimator.init(frame: .zero)
            self.scrollView.es.addInfiniteScrolling(animator: animator) { [weak self] in
                guard let `self` = self else { return }
                self.loadMoreSubject.onNext(())
            }
        } else {
            self.scrollView.es.removeRefreshFooter()
        }
    }
    
}

extension ScrollViewController: DZNEmptyDataSetSource {
    
    open func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let title = self.error?.title, !title.isEmpty {
            return title.styled(with: .alignment(.center), .font(.normal(20)), .color(.darkGray))
        }
        return nil
    }
    
    open func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let message = self.error?.message, !message.isEmpty {
            return message.styled(with: .alignment(.center), .font(.normal(14)), .color(.lightGray))
        }
        return nil
    }
    
    open func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let image = self.error?.image {
            return image
        }
        return UIImage.loading
    }
    
    open func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if let retry = self.error?.retry {
            return retry.styled(with: .font(.normal(15)), .color(state == UIControl.State.normal ? .white : UIColor.white.withAlphaComponent(0.8)))
        }
        return nil
    }
    
    open func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        if state == UIControl.State.normal,
            let image = UIImage.qmui_image(with: .blue, size: CGSize(width: 120, height: 40), cornerRadius: 2.f) {
            return image.withAlignmentRectInsets(UIEdgeInsets(horizontal: (self.view.width - 120) / 2.f * -1.f, vertical: 0))
        }
        return nil
    }
    
    open func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi / 2), 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    open func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .white
    }
}

extension ScrollViewController: DZNEmptyDataSetDelegate {
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return (self.loading == true || self.error != nil)
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return (self.loading == true || self.error == nil)
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        self.emptyDataSetSubject.onNext(())
    }
    
    public func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.emptyDataSetSubject.onNext(())
    }
    
}

extension ScrollViewController: UIScrollViewDelegate {
    
}

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
    
    var startPullToRefresh: Binder<Void> {
        return Binder(self.base) { viewController, _ in
            if let scrollView = viewController.scrollView {
                scrollView.es.startPullToRefresh()
            }
        }
    }
    
}
