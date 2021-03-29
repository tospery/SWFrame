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
    
    enum Kind {
        case ipod
        case iphone
        case ipad
        case simulator
    }

    private static var kindValue: Kind?
    var kind: Kind {
        if let kind = UIDevice.kindValue {
            return kind
        }
        #if TARGET_OS_SIMULATOR
        UIDevice.kindValue = .simulator
        #else
        let model = UIDevice.current.model
        if let _ = model.range(of: "iPod touch") {
            UIDevice.kindValue = .ipod
        } else if let _ = model.range(of: "iPhone") {
            UIDevice.kindValue = .iphone
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            UIDevice.kindValue = .ipad
        } else {
            UIDevice.kindValue = .simulator
        }
        #endif
        return UIDevice.kindValue!
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
    
}
