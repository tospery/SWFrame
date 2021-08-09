//
//  Theme.swift
//  SWFrame
//
//  Created by liaoya on 2021/4/26.
//

import UIKit
import RxTheme

public let themeService = ThemeType.service(initial: .current)

/// 假设从白到黑值为：0~9
public protocol Theme {
    var clearColor: UIColor { get }                             // 透明
    var backgroundColor: UIColor { get }                        // 背景
    var foregroundColor: UIColor { get }                        // 前景
    var lightColor: UIColor { get }                             // 浅色
    var darkColor: UIColor { get }                              // 深色
    var brightColor: UIColor { get }                            // 亮色
    var dimColor: UIColor { get }                               // 暗色
    var primaryColor: UIColor { get }                           // 主色（如：红色）
    var secondaryColor: UIColor { get }                         // 次色（如：蓝色）
    var titleColor: UIColor { get }                             // 标题
    var bodyColor: UIColor { get }                           // 内容
    var headerColor: UIColor { get }                            // 头部
    var footerColor: UIColor { get }                            // 尾部
    var borderColor: UIColor { get }                            // 外边框
    var cornerColor: UIColor { get }                            // 内边框
    var separatorColor: UIColor { get }                         // 分隔条
    var indicatorColor: UIColor { get }                         // 指示器
    var special1Color: UIColor { get }                          // 特殊1
    var special2Color: UIColor { get }                          // 特殊2
    var special3Color: UIColor { get }                          // 特殊3
    var special4Color: UIColor { get }                          // 特殊4
    var special5Color: UIColor { get }                          // 特殊5
    var special6Color: UIColor { get }                          // 特殊6
    var special7Color: UIColor { get }                          // 特殊7
    var special8Color: UIColor { get }                          // 特殊8
    var special9Color: UIColor { get }                          // 特殊9
    var barStyle: UIBarStyle { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var blurStyle: UIBlurEffect.Style { get }
    
    init(color: UIColor?)
}

public protocol ThemeTypeCompatible {
    var theme: Theme { get }
}

public enum ThemeType: ThemeProvider {
    case light(color: UIColor?)
    case dark(color: UIColor?)

    public var isDark: Bool {
        switch self {
        case .dark: return true
        default: return false
        }
    }
    
    public var associatedObject: Theme {
        if let compatible = self as? ThemeTypeCompatible {
            return compatible.theme
        }
        fatalError()
    }
    
    public func toggle(_ color: UIColor? = nil) {
        var theme: ThemeType
        if let color = color {
            switch self {
            case .light: theme = ThemeType.light(color: color)
            case .dark: theme = ThemeType.dark(color: color)
            }
        } else {
            switch self {
            case .light(let color): theme = ThemeType.dark(color: color)
            case .dark(let color): theme = ThemeType.light(color: color)
            }
        }
        theme.save()
        themeService.switch(theme)
    }
    
    public func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.isDark, forKey: Parameter.isDark)
        defaults.set(self.associatedObject.primaryColor.hexString, forKey: Parameter.primaryColor)
        defaults.synchronize()
    }
    
    public static var current: ThemeType {
        let defaults = UserDefaults.standard
        let isDark = defaults.bool(forKey: Parameter.isDark)
        let hexString = defaults.string(forKey: Parameter.primaryColor)
        var color: UIColor?
        if let string = defaults.string(forKey: Parameter.primaryColor),
           let value = UIColor.init(hexString: string) {
            color = value
        }
        let theme = isDark ? ThemeType.dark(color: color) : ThemeType.light(color: color)
        return theme
    }
    
//    public static func configIfNeed(_ color: UIColor) {
//        let defaults = UserDefaults.standard
//        if defaults.string(forKey: Parameter.primaryColor) != nil {
//            return
//        }
//        defaults.set(color.hexString, forKey: Parameter.primaryColor)
//        defaults.synchronize()
//    }

}
