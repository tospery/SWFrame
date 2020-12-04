//
//  IntExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/21.
//

import UIKit
import CoreGraphics

public extension Int {
    
    var bool: Bool {
        return self != 0
    }
    
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
    
    // YJX_TODO
    var subnetMask: String {
        var values = [
            0:  "0.0.0.0",
            1:  "128.0.0.0",
            2:  "192.0.0.0",
            3:  "224.0.0.0",
            4:  "240.0.0.0",
            5:  "248.0.0.0",
            6:  "252.0.0.0",
            7:  "254.0.0.0",
            8:  "255.0.0.0",
            9:  "255.128.0.0",
            10: "255.192.0.0",
            11: "255.224.0.0",
            12: "255.240.0.0",
            13: "255.248.0.0",
            14: "255.252.0.0",
            15: "255.254.0.0",
            16: "255.255.0.0",
            17: "255.255.128.0",
            18: "255.255.192.0",
            19: "255.255.224.0",
            20: "255.255.240.0",
            21: "255.255.248.0",
            22: "255.255.252.0",
            23: "255.255.254.0",
            24: "255.255.255.0",
            25: "255.255.255.128",
            26: "255.255.255.192",
            27: "255.255.255.224",
            28: "255.255.255.240",
            29: "255.255.255.248",
            30: "255.255.255.252",
            31: "255.255.255.254",
            32: "255.255.255.255"
        ]
        return values[self] ?? "255.255.255.255"
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
