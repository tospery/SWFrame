//
//  ScrollViewController.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator
import DZNEmptyDataSet
import BonMot

open class ScrollViewController: BaseViewController {
    
    public let emptyDataSetSubject = PublishSubject<Void>()
    public var scrollView: UIScrollView!
    
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
    }
    
    // MARK: - Method
    public override func bind(reactor: BaseViewReactor) {
        super.bind(reactor: reactor)
        // bind
        self.scrollView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
    }
}

extension ScrollViewController: DZNEmptyDataSetSource {
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let title = self.error?.title, !title.isEmpty {
            return title.styled(with: .alignment(.center), .font(.normal(20)), .color(.darkGray))
        }
        return nil
    }
    
    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let message = self.error?.message, !message.isEmpty {
            return message.styled(with: .alignment(.center), .font(.normal(14)), .color(.lightGray))
        }
        return nil
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let image = self.error?.image {
            return image
        }
        return UIImage.loading
    }
    
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
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
        // guard let error = self as? AppError else { return .serverError }
        //self.error = nil
        self.emptyDataSetSubject.onNext(())
    }
    
}

extension ScrollViewController: UIScrollViewDelegate {
    
}
