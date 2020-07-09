//
//  IntExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/21.
//

import UIKit
import CoreGraphics

public extension Int {
    
    func byteText() -> String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
    
}

public extension IntegerLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
}

public extension FloatLiteralType {
    var f: CGFloat {
        return CGFloat(self)
    }
}
