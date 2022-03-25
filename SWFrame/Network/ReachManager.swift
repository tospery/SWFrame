//
//  ReachManager.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit
import RxSwift
import RxRelay
import Connectivity

public let reachSubject = BehaviorRelay<ConnectivityStatus>.init(value: .determining)

final public class ReachManager {
    
    let connectivity = Connectivity.init()
    public static let shared = ReachManager()

    init() {
    }
    
    deinit {
        self.connectivity.stopNotifier()
    }
    
    func start() {
        let connectivityChanged: (Connectivity) -> Void = { connectivity in
            let status = connectivity.status
            logger.print("网络状态: \(status)", module: .swframe)
            reachSubject.accept(status)
        }
        self.connectivity.pollingInterval = 5
        self.connectivity.isPollingEnabled = true
        self.connectivity.framework = .network
        self.connectivity.whenConnected = connectivityChanged
        self.connectivity.whenDisconnected = connectivityChanged
        self.connectivity.startNotifier()
    }

}
