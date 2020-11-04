//
//  ReachabilityManager.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import Alamofire

public let reachSubject = BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus>.init(value: .unknown)

final public class ReachabilityManager {
    
    // var disposeBag: DisposeBag?
    // var disposeBag: Disposable?
    
    public static let shared = ReachabilityManager()
    
    let network = NetworkReachabilityManager.default
    
    init() {
        
    }
    
    deinit {
//        let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
//        CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, nil, nil)
    }
    
    func start() {
//        let observer = UnsafeRawPointer(Unmanaged.passUnretained(self).toOpaque())
//        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), observer, { (notificationCenter, observer, name, _, _) in
//            if let observer = observer,
//                let name = name {
//                let instance = Unmanaged<ReachabilityManager>.fromOpaque(observer).takeUnretainedValue()
//                instance.onNetworkChange(name.rawValue as String)
//            }
//        }, Notification.Name.networkChanged as CFString, nil, .deliverImmediately)
        
        self.network?.startListening(onUpdatePerforming: { /*[weak self] */ status in
//            guard let `self` = self else { return }
//            if self.disposeBag != nil {
//                self.disposeBag?.dispose()
//                self.disposeBag = nil
//            }
            reachSubject.accept(status)
        })
    }
    
//    func onNetworkChange(_ name : String) {
//        guard name == Notification.Name.networkChanged.rawValue else {
//            return
//        }
//        if self.disposeBag != nil {
//            self.disposeBag?.dispose()
//            self.disposeBag = nil
//        }
//        self.disposeBag = Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance).subscribe(onNext: { _ in
//            DDLogDebug("wifi发送切换了！！！！")
//            reachSubject.accept(.reachable(.ethernetOrWiFi))
//        })
//    }
    
}

// unknown
//public let reachSubject = BehaviorRelay<Reachability.Connection?>.init(value: nil) // .ignore(.none)
//
//final public class ReachabilityManager {
//
//    public static let shared = ReachabilityManager()
//
//    var reachability: Reachability?
//
//    init() {
//        do {
//            reachability = try Reachability()
//            guard let reachability = reachability else { return }
//
//            reachability.whenReachable = { reachability in
//                DispatchQueue.main.async {
//                    reachSubject.accept(reachability.connection)
//                }
//            }
//
//            reachability.whenUnreachable = { reachability in
//                DispatchQueue.main.async {
//                    reachSubject.accept(reachability.connection)
//                }
//            }
//        } catch {
//            log.error(error.localizedDescription)
//        }
//    }
//
//    func start() {
//        guard let reachability = reachability else { return }
//        do {
//            try reachability.startNotifier()
//        } catch {
//            log.error("Unable to start notifier")
//        }
//    }
//}
//
//public extension Reachability.Connection {
//
//    var reachable: Bool {
//        switch self {
//        case .cellular, .wifi:
//            return true
//        default:
//            return false
//        }
//    }
//
//}
