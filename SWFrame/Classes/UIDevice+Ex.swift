//
//  UIDevice+Ex.swift
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
    
    var deviceName: String {
        QMUIHelper.deviceName
    }
    
//    var ip: String? {
//        let server = "https://api.ipify.org" // https://api.myip.la
//        let request = NSURLRequest.init(url: server.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 2)
//        var response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
//        guard let data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: response) else {
//            return nil
//        }
//        let result = String.init(data: data, encoding: .utf8)
//        return result
//    }
    
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
