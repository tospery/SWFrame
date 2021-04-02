//
//  UIDeviceExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/9.
//

import UIKit
import QMUIKit
import UICKeyChainStore
import FCUUID

public extension UIDevice {

    enum Kind {
        case ipod
        case iphone
        case ipad
        case simulator
    }
    
    private static var kindValue: Kind?
    var kind: Kind {
        if UIDevice.kindValue != nil {
            return UIDevice.kindValue!
        }
        if QMUIHelper.isIPod {
            UIDevice.kindValue = .ipod
        } else if QMUIHelper.isIPhone {
            UIDevice.kindValue = .iphone
        } else if QMUIHelper.isIPad {
            UIDevice.kindValue = .ipad
        } else if QMUIHelper.isSimulator {
            UIDevice.kindValue = .simulator
        } else {
            UIDevice.kindValue = .iphone
        }
        return UIDevice.kindValue!
    }
    
    var isIPod: Bool {
        self.kind == .ipod
    }
    
    var isIPhone: Bool {
        self.kind == .iphone
    }
    
    var isIPad: Bool {
        self.kind == .ipad
    }
    
    var isSimulator: Bool {
        self.kind == .simulator
    }

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
