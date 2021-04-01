//
//  UIDeviceExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/9.
//

import UIKit
import UICKeyChainStore
import FCUUID

public extension UIDevice {

    var uuid: String {
        let service = "device.info"
        let accessGroup = UIApplication.shared.team + ".shared"
        let keychain = UICKeyChainStore(service: service, accessGroup: accessGroup)

        let key = "uuid"
        var uuid = keychain[key]
        if uuid?.isEmpty ?? true {
            uuid = FCUUID.uuidForDevice()
            keychain[key] = uuid
        }

        return uuid!
    }
    
    var ip: String? {
        guard let ip = try? String.init(contentsOf: URL.init(string: "https://api.ipify.org")!, encoding: .utf8) else {
            return try? String.init(contentsOf: URL.init(string: "https://api.myip.la")!, encoding: .utf8)
        }
        return ip
    }
    
}
