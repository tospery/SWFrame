//
//  IntExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/21.
//

import UIKit

public extension Int {
    
    func byteText() -> String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
    
}
