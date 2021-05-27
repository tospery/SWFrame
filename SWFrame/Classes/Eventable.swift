//
//  Eventable.swift
//  SWFrame
//
//  Created by liaoya on 2021/5/14.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - 私有变量
private var streams: [String: Any] = [:]

// MARK: - 事件协议
public protocol Eventable {
    associatedtype Event
    static var event: PublishSubject<Event> { get }
}

public extension Eventable {
    static var event: PublishSubject<Event> {
        let key = String(fullname: self)
        if let stream = streams[key] as? PublishSubject<Event> {
            return stream
        }
        let stream = PublishSubject<Event>()
        streams[key] = stream
        return stream
    }
}
