//
//  ReachabilityManager.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import Reachability

final class ReachabilityManager {

    static let shared = ReachabilityManager()
    
    var reachability: Reachability?

    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }

    init() {
        do {
            reachability = try Reachability()
            guard let reachability = reachability else { return }

            reachability.whenReachable = { reachability in
                DispatchQueue.main.async {
                    self.reachSubject.onNext(true)
                }
            }

            reachability.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    self.reachSubject.onNext(false)
                }
            }

            do {
                try reachability.startNotifier()
                reachSubject.onNext(reachability.connection != Reachability.Connection.unavailable)
            } catch {
                log.error("Unable to start notifier")
            }
        } catch {
            log.error(error.localizedDescription)
        }
    }
}
