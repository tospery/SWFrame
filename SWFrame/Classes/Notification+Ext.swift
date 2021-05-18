//
//  Notification+Ext.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/26.
//

import UIKit

public extension Notification.Name {
    static let ThemeChanged = Notification.Name(UIApplication.shared.bundleIdentifier + ".themechanged")
}

