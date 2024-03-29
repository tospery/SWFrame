//
//  Subjection.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/16.
//

import UIKit
import RxSwift
import RxCocoa
//import RealmSwift
import ObjectMapper_JX
// import Cache

public var subjects: [String: Any] = [:]

final public class Subjection {
    
    public class func `for`<T: Subjective>(_ type: T.Type) -> BehaviorRelay<T?> {
        let key = String(fullname: type)
        if let subject = subjects[key] as? BehaviorRelay<T?> {
            return subject
        }
        let subject = BehaviorRelay<T?>(value: type.current)
        subjects[key] = subject
        return subject
    }
    
    public class func update<T: Subjective>(_ type: T.Type, _ value: T?, _ reactive: Bool = true) {
        if let value = value {
            T.storeObject(value, id: nil)
        } else {
            T.eraseObject(id: nil)
        }
        if reactive {
            self.for(type).accept(value)
        } else {
            let key = String(fullname: type)
            subjects[key] = value
        }
    }

}

public protocol Subjective: Storable {
    static var current: Self? { get }
}

public extension Subjective {
    
    static var current: Self? {
        let key = String(fullname: self)
        if let subject = subjects[key] as? BehaviorRelay<Self?> {
            return subject.value
        }
        if let object = Self.cachedObject(id: nil) {
            let subject = BehaviorRelay<Self?>(value: object)
            subjects[key] = subject
            return object
        }
        return nil
    }
    
}

