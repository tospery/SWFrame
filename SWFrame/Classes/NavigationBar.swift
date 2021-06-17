//
//  NavigationBar.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import SwifterSwift

public class NavigationBar: UIView {
    
    public var isTransparet = false
    
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
            return self.qmui_borderColor
        }
        set {
            self.qmui_borderColor = newValue
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
        label.font = .systemFont(ofSize: 17)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .darkText
        label.sizeToFit()
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.qmui_borderPosition = .bottom
        self.qmui_borderWidth = pixelOne
        self.qmui_borderColor = .lightGray
        self.addSubview(self.bgImageView)
        self.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.width, height: UINavigationBar.contentHeightConstant)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgImageView.frame = self.bounds
        
        let padding = 10.f
        var left = padding
        let top = UIScreen.statusBarHeightConstant
        var navBarHeight = UINavigationBar.height
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
        let titleWidth = flat(self.width - margin * 2)
        self.titleLabel.frame = CGRect(
            x: margin, y: UIScreen.statusBarHeightConstant, width: titleWidth, height: navBarHeight
        )
        
        if let titleView = self.titleView {
            titleView.width = min(titleView.width, self.titleLabel.width)
            titleView.height = min(titleView.height, self.titleLabel.height)
            titleView.center = CGPointGetCenterWithRect(self.titleLabel.frame)
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
    
    private func createButton(image: UIImage?, title: String?) -> UIButton {
        let button = UIButton(type: .custom)
        button.titleEdgeInsets = .init(top: -10, left: -20, bottom: 0, right: 0)
        button.imageEdgeInsets = .init(top: -10, left: -20, bottom: 0, right: 0)
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 0, right: 0)
        button.backgroundColor = .clear
        button.titleLabel?.font = .normal(14)
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
        self.qmui_borderPosition = QMUIViewBorderPosition(rawValue: 0)
    }
    
    public func reset() {
        self.backgroundColor = .white
        self.qmui_borderPosition = .bottom
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
