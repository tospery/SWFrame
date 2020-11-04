//
//  UIImageViewExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/3.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import Kingfisher

public extension Reactive where Base: UIImageView {
        
    var image: Binder<ImageSource?> {
        return Binder(self.base) { imageView, resource in
            imageView.isHidden = false
            if let image = resource as? UIImage {
                imageView.image = image
            } else if let url = resource as? URL {
                imageView.kf.setImage(with: url)
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    func image(placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
        return Binder(self.base) { imageView, resource in
            imageView.kf.setImage(with: resource, placeholder: placeholder, options: options)
        }
    }
    
}
