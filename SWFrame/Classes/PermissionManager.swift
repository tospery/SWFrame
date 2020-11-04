//
//  PermissionManager.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/7/26.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

final public class PermissionManager: NSObject {

    public static let shared = PermissionManager()
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()

    private let locateSubject = BehaviorRelay<CLAuthorizationStatus>(value: CLLocationManager.authorizationStatus())
    public var locate: Observable<CLAuthorizationStatus> {
        return locateSubject.asObservable().distinctUntilChanged()
    }
    
    override init() {
        super.init()
    }

    public var locateEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    public func requestLocate() {
        if self.locateSubject.value.isAuthorized {
            return
        }
        self.locationManager.requestWhenInUseAuthorization()
    }

}

extension PermissionManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locateSubject.accept(status)
    }

}

public extension CLAuthorizationStatus {

    public var isAuthorized: Bool {
        return self == .authorizedAlways || self == .authorizedWhenInUse
    }
    
}

