//
//  UIDevice+Ext.swift
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
    
    var keychain: UICKeyChainStore {
        let service = "device.info"
        let accessGroup = UIApplication.shared.team + ".shared"
        let keychain = UICKeyChainStore(service: service, accessGroup: accessGroup)
        return keychain
    }

    var uuid: String {
        let keychain = self.keychain
        let key = "uuid"
        var uuid = keychain[key]
        if uuid?.isEmpty ?? true {
            uuid = FCUUID.uuidForDevice()
            keychain[key] = uuid
        }
        return uuid!
    }
    
    var modelName: String {
        QMUIHelper.deviceModel
    }
    
    var ip: String? {
        guard let ip = try? String.init(contentsOf: URL.init(string: "https://api.ipify.org")!, encoding: .utf8) else {
            return try? String.init(contentsOf: URL.init(string: "https://api.myip.la")!, encoding: .utf8)
        }
        return ip
    }
    
    private static var kindValue: Kind?
    static var kind: Kind {
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
    
    static var isIPod: Bool {
        self.kind == .ipod
    }
    
    static var isIPhone: Bool {
        self.kind == .iphone
    }
    
    static var isIPad: Bool {
        self.kind == .ipad
    }
    
    static var isSimulator: Bool {
        self.kind == .simulator
    }
    
    static var iosVersionDouble: Double {
        (self.current.systemVersion as NSString).doubleValue
    }
    
    static var iosVersionNumber: Int {
        QMUIHelper.numbericOSVersion()
    }
    
}
