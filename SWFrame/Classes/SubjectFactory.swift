//
//  SubjectFactory.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/16.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import ObjectMapper
import Cache

private var subjects3: [String: Any] = [:]

final public class SubjectFactory {

    static public func subject<T: Object>(_ type: T.Type) -> BehaviorRelay<T?> {
        let key = String(describing: T.self)
        if let subject = subjects3[key] as? BehaviorRelay<T?> {
            return subject
        }
        let subject = BehaviorRelay<T?>(value: Realm.default.objects(T.self).first)
        subjects3[key] = subject
        return subject
    }
    
    static public func current<T: Object>(_ type: T.Type) -> T? {
        return self.subject(type).value
    }
    
    static public func update<T: Object>(_ type: T.Type, _ value: T?, _ toCache: Bool = true) {
        let subject = self.subject(type)
        guard let value = value else {
            if toCache {
                if let old = subject.value {
                    try! Realm.default.write {
                        Realm.default.delete(old)
                    }
                }
            }
            subject.accept(nil)
            return
        }

        if toCache {
            try! Realm.default.write {
                Realm.default.add(value)
            }
        }
        subject.accept(value)
    }
    
}
