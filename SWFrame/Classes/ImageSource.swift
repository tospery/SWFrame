//
//  File.swift
//  SWFrame
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

//extension ImageSource {
//
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        if let lImage = lhs as? UIImage,
//           let rImage = rhs as? UIImage {
//            return lImage == rImage
//        }
//        if let lUrl = lhs as? URL,
//           let rUrl = rhs as? URL {
//            return lUrl == rUrl
//        }
//        return false
//    }
//
//}

extension URL: ImageSource {}
extension UIImage: ImageSource {}

