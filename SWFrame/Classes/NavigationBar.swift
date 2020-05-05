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
    
    var itemColor: UIColor?
    
    public var leftButtons: [UIButton] = []
    public var rightButtons: [UIButton] = []
    
    public var titleView: UIView? {
        willSet {
            titleView?.removeFromSuperview()
            titleView = newValue
            if let newValue = newValue {
                self.addSubview(newValue)
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
        self.backgroundColor = .white
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
        return CGSize(width: UIScreen.width, height: navigationContentTopConstant)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgImageView.frame = self.bounds
        
        let padding = 8.f
        var left = padding
        var top = statusBarHeightConstant
        var width = navigationBarHeight
        var height = width
        for (index, button) in self.leftButtons.enumerated() {
            button.width = max(width, button.width)
            button.height = height
            button.top = top
            button.left = left
            left += button.width
        }
        var right = self.width - padding
        for (index, button) in self.rightButtons.enumerated() {
            button.width = max(width, button.width)
            button.height = height
            button.top = top
            button.right = right
            right -= button.width
        }
        
        let leftDistance = self.leftButtons.last?.right ?? 0
        let rightDistance = self.width - (self.rightButtons.last?.left ?? self.width)
        left = max(leftDistance, rightDistance)
        width = flat(self.width - left * 2)
        self.titleLabel.frame = CGRect(x: left, y: statusBarHeightConstant, width: width, height: navigationBarHeight)
        
        if let titleView = self.titleView {
            titleView.width = min(titleView.width, self.titleLabel.width)
            titleView.height = min(titleView.height, self.titleLabel.height)
            titleView.center = CGPointGetCenterWithRect(self.titleLabel.frame)
        }
    }
    
    func addBackButtonToLeft() -> UIButton {
        return self.addButtonToLeft(UIImage.back)
    }
    
    func addCloseButtonToLeft() -> UIButton {
        return self.addButtonToLeft(UIImage.close)
    }
    
    public func addButtonToLeft(_ image: UIImage? = nil, _ title: String? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = self.itemColor
        button.setTitleColor(self.itemColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.setImage(image?.template, for: .normal)
        button.sizeToFit()
        self.addSubview(button)
        
        self.leftButtons.append(button)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return button
    }
    
    public func addButtonToRight(_ image: UIImage? = nil, _ title: String? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = self.itemColor
        button.setTitleColor(self.itemColor, for: .normal)
        button.setTitle(title, for: .normal)
        button.setImage(image?.template, for: .normal)
        button.sizeToFit()
        self.addSubview(button)
        
        self.rightButtons.append(button)
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return button
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
    
    var itemColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.itemColor = color
            for button in view.leftButtons {
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            }
            for button in view.rightButtons {
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            }
        }
    }
    
}
