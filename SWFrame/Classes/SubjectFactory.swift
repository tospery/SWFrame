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

private var subjects: [String: Any] = [:]

final public class SubjectFactory {
    
//    public extension Subjective {
//        static func subject() -> BehaviorRelay<Self?> {
//            let key = String(describing: self)
//            if let subject = subjects[key] as? BehaviorRelay<Self?> {
//                return subject
//            }
//            let realm = try! Realm()
//            let subject = BehaviorRelay<Self?>(value: realm.objects(self).first)
//            subjects[key] = subject
//            return subject
//        }
//
    
    static public func subject<T: Object>(_ type: T.Type) -> BehaviorRelay<T?> {
        let key = String(describing: T.self)
        if let subject = subjects[key] as? BehaviorRelay<T?> {
            return subject
        }
        let realm = try! Realm()
        let subject = BehaviorRelay<T?>(value: realm.objects(T.self).first)
        subjects[key] = subject
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
                    let realm = try! Realm()
                    try! realm.write {
                        realm.delete(old)
                    }
                }
            }
            subject.accept(nil)
            return
        }

        if toCache {
            let realm = try! Realm()
            try! realm.write {
                realm.add(value)
            }
        }
        subject.accept(value)
    }
    
}
