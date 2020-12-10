//
//  UIColorExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import SwifterSwift

public extension UIColor {

    func image(size: CGSize = .init(100)) -> UIImage {
        return .init(color: self, size: size)
    }
    
}
