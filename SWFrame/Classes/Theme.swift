//
//  Theme.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/26.
//

import UIKit
import RxTheme

public let themeService = ThemeType.service(initial: .light)

/// 假设从白到黑值为：0~9
public protocol Theme {
    var backgroundColor: UIColor { get }                        // 白色
    var foregroundColor: UIColor { get }                        // 黑色
    var lightColor: UIColor { get }                             // 浅色
    var darkColor: UIColor { get }                              // 深色
    var brightColor: UIColor { get }                            // 亮色
    var dimColor: UIColor { get }                               // 暗色
    var primaryColor: UIColor { get }                           // 主色（如：红色）
    var secondaryColor: UIColor { get }                         // 次色（如：蓝色）
    var titleColor: UIColor { get }                             // 标题
    var bodyColor: UIColor { get }                              // 主体
    var headerColor: UIColor { get }                            // 头部
    var footerColor: UIColor { get }                            // 尾部
    var borderColor: UIColor { get }                            // 边框
    var separatorColor: UIColor { get }                         // 分隔条
    var indicatorColor: UIColor { get }                         // 指示器
    var special1Color: UIColor { get }                          // 特殊1
    var special2Color: UIColor { get }                          // 特殊2
    var special3Color: UIColor { get }                          // 特殊3
    var special4Color: UIColor { get }                          // 特殊4
    var special5Color: UIColor { get }                          // 特殊5
    var barStyle: UIBarStyle { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var blurStyle: UIBlurEffect.Style { get }
}

public protocol ThemeTypeCompatible {
    var theme: Theme { get }
}

public enum ThemeType: ThemeProvider {
    case light
    case dark

    public var associatedObject: Theme {
        if let compatible = self as? ThemeTypeCompatible {
            return compatible.theme
        }
        fatalError()
    }
}
