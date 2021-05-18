//
//  UILabel+Ext.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/23.
//

import UIKit

public extension UILabel {
    
    static func size(attributedString: NSAttributedString?, withConstraints: CGSize, limitedToNumberOfLines: UInt) -> CGSize {
        guard let attrString = attributedString else { return .zero }
        let label = UILabel.init()
        label.numberOfLines = Int(limitedToNumberOfLines)
        label.attributedText = attrString
        return label.sizeThatFits(withConstraints)
    }
    
}


