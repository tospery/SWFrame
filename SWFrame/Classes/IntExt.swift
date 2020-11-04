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
    
    init?(any: Any?) {
        if let string = any as? String {
            self.init(string)
            return
        }
        if let number = any as? Int {
            self = number
            return
        }
        return nil
    }
    
}

extension UInt32 {
    public func ip(isBigEndian: Bool = false, isIPV4: Bool = true ) -> String {
        let ip = self
        let byte1 = UInt8(ip & 0xff)
        let byte2 = UInt8((ip>>8) & 0xff)
        let byte3 = UInt8((ip>>16) & 0xff)
        let byte4 = UInt8((ip>>24) & 0xff)
        if isBigEndian {
            return "\(byte1).\(byte2).\(byte3).\(byte4)"
        }
        return "\(byte4).\(byte3).\(byte2).\(byte1)"
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
