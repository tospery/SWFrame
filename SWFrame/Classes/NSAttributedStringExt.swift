//
//  NSAttributedStringExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/5/10.
//

import UIKit

public extension NSAttributedString {

    func size(thatFits size: CGSize) -> CGSize {
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).size
    }

    func width() -> CGFloat {
        return self.size(thatFits: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
    }

    func height(thatFitsWidth width: CGFloat) -> CGFloat {
        return self.size(thatFits: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
    }

}
