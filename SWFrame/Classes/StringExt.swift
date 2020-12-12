//
//  StringExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/14.
//

import UIKit
import QMUIKit
import ObjectMapper
import SwifterSwift

public extension String {
    
    // MARK: - Properties
    var color: UIColor? {
        return UIColor(hexString: self)
    }
    
    
//    var attributedString: NSAttributedString {
//        return NSAttributedString(string: self)
//    }
    
    // MARK: - Initializers
    init?(any: Any?) {
        if let number = any as? Int {
            self.init(number)
            return
        }
        if let string = any as? String {
            self = string
            return
        }
        return nil
    }
    
    init<Subject>(fullname subject: Subject) {
        self.init(reflecting: subject)
        self = self.replacingOccurrences(of: UIApplication.shared.name + ".", with: "")
    }
    
//    func rect(with size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGRect {
//        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//        let rect = self.boundingRect(with: size, options: options, attributes: attributes, context: nil)
//        return CGRectFlatted(rect)
//    }
//    
//    func size(thatFits size: CGSize, font: UIFont, maxLines: Int = 0) -> CGSize {
//        let attributes: [NSAttributedString.Key: Any] = [.font: font]
//        var size = self.rect(with: size, attributes: attributes).size
//        if maxLines > 0 {
//            size.height = flat(min(size.height, maxLines.f * font.lineHeight))
//        }
//        return size
//    }
//    
//    func width(with font: UIFont, maxLines: Int = 0) -> CGFloat {
//        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
//        return self.size(thatFits: size, font: font, maxLines: maxLines).width
//    }
//    
//    func height(thatFitsWidth width: CGFloat, font: UIFont, maxLines: Int = 0) -> CGFloat {
//        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
//        return self.size(thatFits: size, font: font, maxLines: maxLines).height
//    }
    
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
    
}

//extension String: ModelType {
//
////    public init?(map: Map) {
////        self.init()
////    }
////
////    public mutating func mapping(map: Map) {
////
////    }
//    
//}
