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
    
    public lazy var titleLabel: Label = {
        let label = Label()
        label.font = .normal(15)
        label.textColor = .darkGray
        label.sizeToFit()
        return label
    }()
    
    public lazy var detailLabel: Label = {
        let label = Label()
        label.font = .normal(13)
        label.textAlignment = .right
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.indicator.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
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
        self.contentView.addSubview(self.indicatorImageView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.indicatorImageView.sizeToFit()
        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter
        self.indicatorImageView.right = self.contentView.width - 15
        
        self.titleLabel.sizeToFit()
        self.titleLabel.left = 15
        self.titleLabel.top = self.titleLabel.topWhenCenter
        self.titleLabel.width = min(self.titleLabel.width, self.contentView.width / 2)
        
        self.detailLabel.sizeToFit()
        self.detailLabel.top = self.detailLabel.topWhenCenter
        self.detailLabel.right = self.indicatorImageView.left - 8
    }
    
    public func bind(reactor: NormalCollectionItem) {
        super.bind(item: reactor)
        reactor.state.map{ $0.title }
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map{ $0.detail }
            .bind(to: self.detailLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map{ _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }
    
}

