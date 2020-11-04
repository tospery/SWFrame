//
//  BehaviorRelayExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/19.
//

import UIKit
import RxSwift
import RxCocoa

//public extension BehaviorRelay {
//
//    class func subject<T: Subjective>(_ type: T.Type, _ key: String? = nil) -> BehaviorRelay<T?> {
//        let key = key ?? String(describing: self)
//        if let subject = subjects[key] as? BehaviorRelay<T?> {
//            return subject
//        }
//        let subject = BehaviorRelay<T?>(value: type.current)
//        subjects[key] = subject
//        return subject
//    }
//
//}
