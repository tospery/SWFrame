//
//  ScrollViewController+Ext.swift
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
import MJRefresh

extension ScrollViewController: DZNEmptyDataSetSource {
    
    open func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let title = self.error?.asSWError.failureReason, !title.isEmpty {
            return title.styled(with: .alignment(.center),
                                .font(.systemFont(ofSize: 20)),
                                .color(.title))
        }
        return nil
    }
    
    open func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let message = self.error?.asSWError.errorDescription, !message.isEmpty {
            return message.styled(with: .alignment(.center),
                                  .font(.systemFont(ofSize: 14)),
                                  .color(.body))
        }
        return nil
    }
    
    open func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let image = self.error?.asSWError.displayImage {
            return image
        }
        return UIImage.loading
    }
    
    open func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if let retry = self.error?.asSWError.recoverySuggestion {
            return retry.styled(with: .font(.systemFont(ofSize: 15)),
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
    
    open func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        -metric(40)
    }
    
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
