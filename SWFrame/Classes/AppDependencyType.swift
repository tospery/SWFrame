//
//  AppDependencyType.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import URLNavigator

public protocol AppDependencyType {
    
    var window: UIWindow! { get }
    var navigator: NavigatorType { get }
    var provider: ProviderType { get }
    var disposeBag: DisposeBag { get }
    
    func initialScreen(with window: inout UIWindow?)
    
    func application(_ application: UIApplication, entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func application(_ application: UIApplication, leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func applicationDidBecomeActive(_ application: UIApplication)

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool
}
