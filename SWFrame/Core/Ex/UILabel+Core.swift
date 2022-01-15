//
//  UILabelExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import Foundation

public extension UILabel {
    
    static func size(attributedString: NSAttributedString?, withConstraints: CGSize, limitedToNumberOfLines: UInt) -> CGSize {
        guard let attrString = attributedString else { return .zero }
        let label = UILabel.init()
        label.numberOfLines = Int(limitedToNumberOfLines)
        label.attributedText = attrString
        return label.sizeThatFits(withConstraints)
    }
    
}
