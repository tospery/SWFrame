//
//  UIApplicationExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/8.
//

import UIKit

public extension UIApplication {
    
    var team: String {
        let query = [
            kSecClass as NSString: kSecClassGenericPassword as NSString,
            kSecAttrAccount as NSString: "bundleSeedID" as NSString,
            kSecAttrService as NSString: "" as NSString,
            kSecReturnAttributes as NSString: kCFBooleanTrue as NSNumber
        ] as NSDictionary
        
        var result: CFTypeRef?
        let status = Int(SecItemCopyMatching(query, &result))
        if status == Int(errSecSuccess),
            let attributes = result as? NSDictionary,
            let accessGroup = attributes[kSecAttrAccessGroup as NSString] as? NSString,
            let components = accessGroup.components(separatedBy: ".") as? NSArray,
            let bundleSeedID = components.objectEnumerator().nextObject() as? String {
            return bundleSeedID
        }
        
        return ""
    }
    
    var scheme: String {
        var scheme: String? = nil
        if let types = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? Array<Dictionary<String, Any>> {
            for info in types {
                if let name = info["CFBundleURLName"] as? String, name == "app" {
                    if let schemes = info["CFBundleURLSchemes"] as? Array<String> {
                        scheme = schemes.first
                    }
                }
            }
        }
        return scheme ?? ""
    }
    
    var bundleIdentifier: String {
        return Bundle.main.infoDictionary?[kCFBundleIdentifierKey as String] as! String
    }
    
    var appIcon: UIImage? {
        guard let info = (Bundle.main.infoDictionary as NSDictionary?) else { return nil }
        guard let name = (info.value(forKeyPath: "CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles") as? Array<String>)?.last else { return nil }
        return UIImage(named: name)
    }
    
}
