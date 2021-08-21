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
        self.shouldRefresh = reactor.parameters.bool(for: Parameter.shouldRefresh) ?? false
        self.shouldLoadMore = reactor.parameters.bool(for: Parameter.shouldLoadMore) ?? false
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
            .subscribe(onNext: { [weak self] themeType in
                guard let `self` = self else { return }
                self.handle(theme: themeType)
            })
            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.scrollView.rx.backgroundColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.frame = self.contentFrame
    }
    
    // MARK: - Method
    open override func bind(reactor: BaseViewReactor) {
        super.bind(reactor: reactor)
    }
    
}

extension ScrollViewController: DZNEmptyDataSetSource {
    
    open func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let title = self.error?.asSWError.failureReason, !title.isEmpty {
            return title.styled(with: .alignment(.center),
                                .font(.bold(20)),
                                .color(.foreground))
        }
        return nil
    }
    
    open func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let message = self.error?.asSWError.errorDescription, !message.isEmpty {
            return message.styled(with: .alignment(.center),
                                  .font(.normal(14)),
                                  .color(.foreground))
        }
        return nil
    }
    
    open func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let image = self.error?.asSWError.displayImage {
            return image
        }
        return UIImage.loading.qmui_image(withTintColor: .foreground)
    }
    
    open func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if let retry = self.error?.asSWError.recoverySuggestion {
            return retry.styled(with: .font(.normal(15)),
                                .color(state == UIControl.State.normal ? UIColor.background : UIColor.background.withAlphaComponent(0.8)))
        }
        return nil
    }
    
    open func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        if state == UIControl.State.normal,
            let image = UIImage.qmui_image(with: .primary, size: CGSize(width: 120, height: 40), cornerRadius: 2.f) {
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
        .background
    }
    
//    open func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
//        -metric(40)
//    }
    
}

extension ScrollViewController: DZNEmptyDataSetDelegate {
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        let should = (self.isLoading == true || self.error != nil)
        return should
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        let should = (self.isLoading == true && self.error == nil)
        return should
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
