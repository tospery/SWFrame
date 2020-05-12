//
//  CGSizeExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/9.
//

import UIKit

public extension CGSize {

    static var s8: CGSize { .init(width: 8, height: 8) }
    static var s16: CGSize { .init(width: 16, height: 16) }
    static var s32: CGSize { .init(width: 32, height: 32) }
    static var s64: CGSize { .init(width: 64, height: 64) }
    static var s128: CGSize { .init(width: 128, height: 128) }
    static var s256: CGSize { .init(width: 256, height: 256) }
    static var s512: CGSize { .init(width: 512, height: 512) }
    static var s1024: CGSize { .init(width: 1024, height: 1024) }

    init(_ value: CGFloat) {
        self.init(width: value, height: value)
    }

}
