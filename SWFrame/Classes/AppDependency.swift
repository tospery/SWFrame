//
//  AppDependency.swift
//  SWFrame
//
//  Created by liaoya on 2021/11/18.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator
import SwifterSwift

open class AppDependency {
    
    public let navigator: NavigatorType
    public let provider: ProviderType
    public let disposeBag = DisposeBag()
    public var window: UIWindow!
    
    // MARK: - Initialize
    init() {
        self.navigator = Navigator()
        self.provider = Provider()
    }
    
    open func initialScreen(with window: inout UIWindow?) {
        
    }
    
    // MARK: - Application
    open func application(_ application: UIApplication, entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        RuntimeManager.shared.setup()
        LibraryManager.shared.setup()
        AppearanceManager.shared.setup()
        RouterManager.shared.setup(provider: self.provider, navigator: self.navigator)
        logger.print("运行环境: \(UIApplication.shared.inferredEnvironment)", module: .swframe)
        logger.print("设备型号: \(UIDevice.current.deviceName)", module: .swframe)
        logger.print("系统版本: \(UIDevice.current.systemVersion)", module: .swframe)
        logger.print("屏幕尺寸: \(UIScreen.main.bounds.size)", module: .swframe)
        logger.print("安全区域: \(UIScreen.safeArea)", module: .swframe)
        logger.print("状态栏: \(SWHelper.sharedInstance().statusBarHeightConstant)", module: .swframe)
        logger.print("导航栏: \(SWHelper.sharedInstance().navigationBarHeight)", module: .swframe)
        logger.print("标签栏: \(SWHelper.sharedInstance().tabBarHeight)", module: .swframe)
        logger.print("底部栏: \(UIScreen.safeBottom)", module: .swframe)
    }
    
    open func application(_ application: UIApplication, leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
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
