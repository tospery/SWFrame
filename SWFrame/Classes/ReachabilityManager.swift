//
//  ReachabilityManager.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/6.
//

import UIKit
import RxSwift
import Reachability

final public class ReachabilityManager {

    public static let shared = ReachabilityManager()
    
    var reachability: Reachability?

    let reachSubject = ReplaySubject<Reachability.Connection>.create(bufferSize: 1)
    public var reach: Observable<Reachability.Connection> {
        return reachSubject.asObservable().distinctUntilChanged()
    }

    init() {
        do {
            reachability = try Reachability()
            guard let reachability = reachability else { return }

            reachability.whenReachable = { reachability in
                DispatchQueue.main.async {
                    self.reachSubject.onNext(reachability.connection)
                }
            }

            reachability.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    self.reachSubject.onNext(reachability.connection)
                }
            }

            do {
                try reachability.startNotifier()
                reachSubject.onNext(reachability.connection)
            } catch {
                log.error("Unable to start notifier")
            }
        } catch {
            log.error(error.localizedDescription)
        }
    }
}
