//
//  NavigationBar.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit

import RxSwift
import RxCocoa
import SwifterSwift
import RxTheme

public class NavigationBar: UIView {
    
    public enum Style: Int {
        case automatic
        case nosafe
    }
    
    public var isTransparet = false
    public var style = Style.automatic
    
    @objc public dynamic var titleColor: UIColor? {
        get {
            return self.titleLabel.textColor
        }
        set {
            self.titleLabel.textColor = newValue
        }
    }

    @objc public dynamic var barColor: UIColor? {
        get {
            return self.backgroundColor
        }
        set {
            if self.isTransparet {
                self.backgroundColor = .clear
            } else {
                self.backgroundColor = newValue
            }
        }
    }

    @objc public dynamic var itemColor: UIColor? {
        get {
            return self.tintColor
        }
        set {
            self.tintColor = newValue
            for button in self.leftButtons {
                button.tintColor = newValue
                button.setTitleColor(newValue, for: .normal)
            }
            for button in self.rightButtons {
                button.tintColor = newValue
                button.setTitleColor(newValue, for: .normal)
            }
        }
    }

    @objc public dynamic var lineColor: UIColor? {
        get {
            return self.swf_borderColor
        }
        set {
            self.swf_borderColor = newValue
        }
    }
    
    public var leftButtons: [UIButton] = []
    public var rightButtons: [UIButton] = []

    public var titleView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let titleView = titleView {
                self.addSubview(titleView)
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }
    
    public lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.sizeToFit()
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .normal(17)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .darkText
        label.sizeToFit()
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        // YJX_TODO
//        self.swf_borderPosition = .bottom
//        self.swf_borderWidth = pixelOne
//        self.swf_borderColor = .lightGray
        self.addSubview(self.bgImageView)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = self.style == .automatic ? navigationContentTopConstant : navigationBarHeight
        return CGSize(width: deviceWidth, height: height)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgImageView.frame = self.bounds
        
        let padding = 10.f
        var left = padding
        let top = statusBarHeightConstant
        var navBarHeight = navigationBarHeight
        for button in self.leftButtons {
            button.sizeToFit()
            button.height = min(navBarHeight, button.height)
            button.top = top + (navBarHeight - button.height) / 2.f
            button.left = left
            left += button.width
        }
        var right = self.width - padding
        for button in self.rightButtons {
            button.sizeToFit()
            button.height = min(navBarHeight, button.height)
            button.top = top + (navBarHeight - button.height) / 2.f
            button.right = right
            right -= button.width
        }
        
        let leftDistance = self.leftButtons.last?.right ?? 0
        let rightDistance = self.width - (self.rightButtons.last?.left ?? self.width)
        let margin = max(leftDistance, rightDistance)
        let titleWidth = (self.width - margin * 2).flat
        self.titleLabel.frame = CGRect(
            x: margin, y: statusBarHeightConstant, width: titleWidth, height: navBarHeight
        )
        
        if let titleView = self.titleView {
            titleView.width = min(titleView.width, self.titleLabel.width)
            titleView.height = min(titleView.height, self.titleLabel.height)
            titleView.center = .init(x: self.titleLabel.frame.midX, y: self.titleLabel.frame.midY)
            self.titleLabel.isHidden = true
        } else {
            self.titleLabel.isHidden = false
        }
    }
    
    func addBackButtonToLeft() -> UIButton {
        return self.addButtonToLeft(image: UIImage.back)
    }
    
    func addCloseButtonToLeft() -> UIButton {
        return self.addButtonToLeft(image: UIImage.close)
    }
    
    public func addButtonToLeft(image: UIImage? = nil, title: String? = nil) -> UIButton {
        let button = self.createButton(image: image, title: title)
        self.addSubview(button)
        
        self.leftButtons.append(button)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return button
    }
    
    public func addButtonToRight(image: UIImage? = nil, title: String? = nil) -> UIButton {
        let button = self.createButton(image: image, title: title)
        self.addSubview(button)
        
        self.rightButtons.append(button)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return button
    }
    
    public func addButtonToRight(button: UIButton) -> UIButton {
        self.addSubview(button)
        
        self.rightButtons.append(button)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return button
    }
    
    public func createButton(image: UIImage?, title: String?) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleEdgeInsets = .init(top: -10, left: -20, bottom: 0, right: 0)
        button.imageEdgeInsets = .init(top: -10, left: -20, bottom: 0, right: 0)
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 0, right: 0)
        button.backgroundColor = .clear
        button.titleLabel?.font = .normal(16)
        button.tintColor = self.itemColor
        button.setTitleColor(self.itemColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.setImage(image?.template, for: .normal)
        button.sizeToFit()
        return button
    }
    
    public func removeAllLeftButtons() {
        for button in self.leftButtons {
            button.removeFromSuperview()
        }
        self.leftButtons.removeAll()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    public func transparet() {
        self.backgroundColor = .clear
        // YJX_TODO self.swf_borderPosition = SWFViewBorderPosition(rawValue: 0)
    }
    
    public func reset() {
        self.backgroundColor = .white
        // YJX_TODO self.swf_borderPosition = .bottom
    }
    
}

// MARK: - UIView
public extension Reactive where Base: NavigationBar {

    var barColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.barColor = color
        }
    }

    var itemColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.itemColor = color
        }
    }
    
    var titleColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.titleColor = color
        }
    }

    var lineColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.lineColor = color
        }
    }
    
}

public extension ThemeProxy where Base: NavigationBar {
    
    var lineColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.swf_borderColor = newValue.value
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.lineColor)
            hold(disposable, for: "lineColor")
        }
    }

    var titleColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.titleLabel.textColor = newValue.value
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.titleColor)
            hold(disposable, for: "titleColor")
        }
    }

    var itemColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            base.tintColor = newValue.value
            for button in base.leftButtons {
                button.tintColor = newValue.value
                button.setTitleColor(newValue.value, for: .normal)
            }
            for button in base.rightButtons {
                button.tintColor = newValue.value
                button.setTitleColor(newValue.value, for: .normal)
            }
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.itemColor)
            hold(disposable, for: "itemColor")
        }
    }
    
    var barColor: ThemeAttribute<UIColor?> {
        get { fatalError("set only") }
        set {
            if base.isTransparet {
                base.backgroundColor = .clear
            } else {
                base.backgroundColor = newValue.value
            }
            let disposable = newValue.stream
                .take(until: base.rx.deallocating)
                .observe(on: MainScheduler.instance)
                .bind(to: base.rx.barColor)
            hold(disposable, for: "barColor")
        }
    }
    
}
