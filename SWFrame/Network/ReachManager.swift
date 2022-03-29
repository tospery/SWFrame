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
            if status == .connected {
                return
            }
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

extension ConnectivityStatus {
    
    public var isCellular: Bool { self == .connectedViaCellular || self == .connectedViaCellularWithoutInternet }
    public var isWifi: Bool { self == .connectedViaWiFi || self == .connectedViaWiFiWithoutInternet }
    public var hasInternet: Bool { self == .connectedViaCellular || self == .connectedViaWiFi }
    
}

extension ConnectivityStatus: Equatable {
    
    static func == (lhs: ConnectivityStatus, rhs: ConnectivityStatus) -> Bool {
        switch (lhs, rhs) {
        case (.connected, .connected),
             (.connectedViaCellular, .connectedViaCellular),
             (.connectedViaCellularWithoutInternet, .connectedViaCellularWithoutInternet),
             (.connectedViaWiFi, .connectedViaWiFi),
             (.connectedViaWiFiWithoutInternet, .connectedViaWiFiWithoutInternet),
             (.determining, .determining),
             (.notConnected, .notConnected):
            return true
        default:
            return false
        }
    }
    
}
