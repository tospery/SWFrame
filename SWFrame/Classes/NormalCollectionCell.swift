//
//  NormalCollectionCell.swift
//  Kujia
//
//  Created by 杨建祥 on 2020/4/19.
//  Copyright © 2020 杨建祥. All rights reserved.
//

import UIKit
import QMUIKit
import ReactorKit

open class NormalCollectionCell: BaseCollectionCell, View {
    
    public lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.font = .normal(15)
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()
    
    public lazy var detailLabel: SWLabel = {
        let label = SWLabel()
        label.font = .normal(13)
        label.textAlignment = .right
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    public lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.sizeToFit()
        return imageView
    }()
    
    public lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.qmui_borderPosition = .bottom
        self.qmui_borderWidth = pixelOne
        self.qmui_borderColor = .lightGray
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailLabel)
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.indicatorImageView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.detailLabel.text = nil
        self.avatarImageView.image = nil
        self.indicatorImageView.isHidden = true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.indicatorImageView.sizeToFit()
        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter
        self.indicatorImageView.right = self.contentView.width - 15
        
        self.titleLabel.sizeToFit()
        self.titleLabel.left = 15
        self.titleLabel.top = self.titleLabel.topWhenCenter
        
        self.detailLabel.sizeToFit()
        self.detailLabel.top = self.detailLabel.topWhenCenter
        if self.indicatorImageView.isHidden {
            self.detailLabel.right = self.indicatorImageView.right
        } else {
            self.detailLabel.right = self.indicatorImageView.left - 8
        }
        
        if self.avatarImageView.isHidden {
            self.avatarImageView.frame = .zero
        } else {
            self.avatarImageView.sizeToFit()
            self.avatarImageView.height = flat(self.contentView.height * 0.6)
            self.avatarImageView.width = self.avatarImageView.height
            self.avatarImageView.top = self.avatarImageView.topWhenCenter
            self.avatarImageView.right = self.detailLabel.left - 8
            self.avatarImageView.cornerRadius = self.avatarImageView.height / 2.0
        }
    }
    
    public func bind(reactor: NormalCollectionItem) {
        super.bind(item: reactor)
        reactor.state.map{ !$0.showIndicator }
            .bind(to: self.indicatorImageView.rx.isHidden)
            .disposed(by: self.disposeBag)
        reactor.state.map{ $0.title }
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map{ $0.detail }
            .bind(to: self.detailLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map{ $0.avatar }
            .bind(to: self.avatarImageView.rx.image)
            .disposed(by: self.disposeBag)
        reactor.state.map{ _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
}

