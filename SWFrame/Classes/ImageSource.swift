//
//  File.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/21.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import Kingfisher

public protocol ImageSource {
    
}

extension URL: ImageSource {}
extension UIImage: ImageSource {}

