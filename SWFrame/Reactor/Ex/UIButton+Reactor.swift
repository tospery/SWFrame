//
//  UIButtonExtensions.swift
//  SWFrame
//
//  Created by liaoya on 2021/8/23.
//

import UIKit

public extension UIButton {
    
    func zoomOut(extraWidth: CGFloat, extraHeight: CGFloat) {
        let halfWidth = extraWidth / 2.f
        self.titleEdgeInsets = .init(top: -halfWidth, left: -extraWidth, bottom: 0, right: 0)
        self.imageEdgeInsets = .init(top: -halfWidth, left: -extraWidth, bottom: 0, right: 0)
        self.contentEdgeInsets = .init(top: halfWidth, left: extraWidth, bottom: 0, right: 0)
    }
    
}

