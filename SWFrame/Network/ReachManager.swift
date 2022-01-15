//
//  ReachManager.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit
import RxSwift
import RxRelay
import Alamofire

public let reachSubject = BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus>.init(value: .unknown)

final public class ReachManager {
    
    public static let shared = ReachManager()
    
    let network = NetworkReachabilityManager.init()
    
    init() {
        
    }
    
    deinit {
    }
    
    func start() {
        self.network?.startListening(onUpdatePerforming: { status in
            logger.print("网络状态: \(status)", module: .swframe)
            reachSubject.accept(status)
        })
    }

}

extension NetworkReachabilityManager.NetworkReachabilityStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: return "未知网络"
        case .notReachable: return "网络不可达"
        case let .reachable(type): return type == .cellular ? "cellular" : "wifi"
        }
    }
}

