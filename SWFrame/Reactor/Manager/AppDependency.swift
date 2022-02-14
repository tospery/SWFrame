//
//  AppDependency.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit
import RxSwift
import URLNavigator
import DeviceKit
import SwifterSwift

open class AppDependency {
    
    public let navigator: NavigatorType
    public let provider: ProviderType
    public let disposeBag = DisposeBag()
    public var window: UIWindow!
    
    public static var shared = AppDependency()
    
    // MARK: - Initialize
    public init() {
        self.navigator = Navigator()
        self.provider = Provider()
    }
    
    open func initialScreen(with window: inout UIWindow?) {
        
    }
    
    // MARK: - Test
    open func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    }
    
    // MARK: - Update
    open func updateConfiguration() {
    }
    
    open func updatePreference() {
    }
    
    open func updateUser() {
    }
    
    // MARK: - Lifecycle
    open func application(_ application: UIApplication, entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        logger.print("运行环境: \(UIApplication.shared.inferredEnvironment)", module: .swframe)
        logger.print("设备型号: \(Device.current.safeDescription)", module: .swframe)
        logger.print("系统版本: \(UIDevice.current.systemVersion)", module: .swframe)
        logger.print("屏幕尺寸: \(UIScreen.main.bounds.size)", module: .swframe)
        logger.print("安全区域: \(safeArea)", module: .swframe)
        logger.print("状态栏: \(statusBarHeightConstant)", module: .swframe)
        logger.print("导航栏: \(navigationBarHeight)", module: .swframe)
        logger.print("标签栏: \(tabBarHeight)", module: .swframe)
    }
    
    open func application(_ application: UIApplication, leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.updateConfiguration()
        self.updatePreference()
        self.updateUser()
#if DEBUG
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.test(launchOptions: launchOptions)
        }
#endif
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
    }

    open func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
    }
    
    // MARK: - URL
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        true
    }
    
    // MARK: - Activity
    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        true
    }
    
}

