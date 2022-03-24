//
//  StringExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension String {
    
    // MARK: - Properties
    var forcedURL: URL? {
        var url = URL.init(string: self)
        if url == nil {
            let raw = self.trimmed
            url = URL.init(string: raw)
            if url == nil {
                url = URL.init(string: raw.urlDecoded)
            }
            if url == nil {
                url = URL.init(string: raw.urlEncoded)
            }
        }
        return url
    }
    
    var color: UIColor? {
        return UIColor(hexString: self)
    }
    
    var method: String {
        self.replacingOccurrences(of: "/", with: " ").camelCased
    }
    
    var emptyToNil: String? {
        self.isEmpty ? nil : self
    }
    
    init<Subject>(fullname subject: Subject) {
        self.init(reflecting: subject)
        if let displayName = UIApplication.shared.displayName {
            self = self.replacingOccurrences(of: "\(displayName).", with: "")
        }
        self = self.replacingOccurrences(of: UIApplication.shared.bundleName + ".", with: "")
    }
    
    var urlPlaceholderValue: String {
        guard self.hasPrefix("<") else { return self }
        guard self.hasSuffix(":_>") else { return self }
        return self.removingPrefix("<").removingPrefix(":_>")
    }
    
    var camelCasedWithoutUnderline: String {
        var result = ""
        let cmps = self.components(separatedBy: "_")
        for (index, cmp) in cmps.enumerated() {
            if index == 0 {
                result += cmp.lowercased()
            } else {
                result += cmp.lowercased().capitalized
            }
        }
        return result
    }

    // MARK: - Methods
    func nsRange(from range: Range<String.Index>) -> NSRange {
        .init(range, in: self)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else {
            return nil
        }
        return from ..< to
    }
    
    var ipValue: UInt32 {
        let array = self.components(separatedBy: ".")
        if array.count != 4 {
            return 0
        }
        let seg1 = Int(array[0]) ?? 0
        let seg2 = Int(array[1]) ?? 0
        let seg3 = Int(array[2]) ?? 0
        let seg4 = Int(array[3]) ?? 0
        
        var value: UInt32 = 0
        value |= UInt32((seg1 & 0xff) << 24)
        value |= UInt32((seg2 & 0xff) << 16)
        value |= UInt32((seg3 & 0xff) << 8)
        value |= UInt32((seg4 & 0xff) << 0)
        return value
    }
    
}
