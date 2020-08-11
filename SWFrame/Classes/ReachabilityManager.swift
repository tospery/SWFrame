//
//  ReachabilityManager.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import Reachability

public let reachSubject = BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus>.init(value: .unknown)

final public class ReachabilityManager {

    public static let shared = ReachabilityManager()
    
    let network = NetworkReachabilityManager.default
    
    init() {
    }
    
    func start() {
        self.network?.startListening(onUpdatePerforming: { status in
            reachSubject.accept(status)
        })
    }
    
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
