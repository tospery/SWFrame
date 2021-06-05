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

public let reachSubject = BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus>.init(value: .unknown)

final public class ReachabilityManager {
    
    public static let shared = ReachabilityManager()
    
    let network = NetworkReachabilityManager.default
    
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

