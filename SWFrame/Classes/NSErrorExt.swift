//
//  NSErrorExt.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/7.
//

import Foundation

extension NSError: SWCompatibleError {
    public var isNetwork: Bool {
        self.domain == NSURLErrorDomain
    }
    public var isServer: Bool {
        self.code == 500
    }
    public var isUserExpired: Bool {
        self.code == 401
    }
}
