//
//  IntExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension Int {
    
    var bool: Bool {
        return self != 0
    }
    
    var kilobytesText: String {
        (self * 1024).bytesText
    }
    
    var bytesText: String {
        ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
    
    var formatted: String {
        let sign = ((self < 0) ? "-" : "" )
        if self < 1000 {
            return "\(sign)\(self)"
        }
        let num = fabs(self.double)
        let exp: Int = Int(log10(num) / 3.0 )
        let units: [String] = ["K", "M", "G", "T", "P", "E"]
        let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10
        return "\(sign)\(roundedNum)\(units[exp-1])"
    }
    
    var decimalText: String? {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber.init(value: self))
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
