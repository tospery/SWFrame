//
//  UIApplicationExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation
import SwifterSwift

public extension UIApplication {
    
//    var channel: Int {
//        switch self.inferredEnvironment {
//        case .debug: return 1
//        case .testFlight: return 2
//        case .appStore: return 3
//        }
//    }
    
    var team: String {
        let query = [
            kSecClass as NSString: kSecClassGenericPassword as NSString,
            kSecAttrAccount as NSString: "bundleSeedID" as NSString,
            kSecAttrService as NSString: "" as NSString,
            kSecReturnAttributes as NSString: kCFBooleanTrue as NSNumber
        ] as NSDictionary
        
        var result: CFTypeRef?
        var status = Int(SecItemCopyMatching(query, &result))
        if status == Int(errSecItemNotFound) {
            status = Int(SecItemAdd(query, &result))
        }
        if status == Int(errSecSuccess),
            let attributes = result as? NSDictionary,
            let accessGroup = attributes[kSecAttrAccessGroup as NSString] as? NSString,
            let bundleSeedID = (accessGroup.components(separatedBy: ".") as NSArray).objectEnumerator().nextObject() as? String {
            return bundleSeedID
        }
        
        return ""
    }
    
    var urlScheme: String {
        self.urlScheme(name: "app") ?? ""
    }
    
    var name: String {
        self.displayName ?? self.bundleName
    }
    
    var displayName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    
    var bundleName: String {
        Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
    }
    
    var bundleIdentifier: String {
        Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as! String
    }
    
    var appIcon: UIImage? {
        guard let info = (Bundle.main.infoDictionary as NSDictionary?) else { return nil }
        guard let name = (info.value(forKeyPath: "CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles") as? Array<String>)?.last else { return nil }
        return UIImage(named: name)
    }
    
    @objc var pageStart: Int { 1 }
    
    @objc var pageSize: Int { 20 }
    
    @objc var baseApiUrl: String {
        return "https://\(self.urlScheme).com"
    }
    
    @objc var baseWebUrl: String {
        return "https://\(self.urlScheme).com"
    }
    
    func urlScheme(name: String) -> String? {
        var scheme: String? = nil
        if let types = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? Array<Dictionary<String, Any>> {
            for info in types {
                if let urlName = info["CFBundleURLName"] as? String,
                   urlName == name {
                    if let urlSchemes = info["CFBundleURLSchemes"] as? [String] {
                        scheme = urlSchemes.first
                    }
                }
            }
        }
        return scheme
    }

}

//extension UIApplication.Environment: CustomStringConvertible {
//    public var description: String {
//        switch self {
//        case .debug: return "Debug"
//        case .testFlight: return "TestFlight"
//        case .appStore: return "AppStore"
//        }
//    }
//}
