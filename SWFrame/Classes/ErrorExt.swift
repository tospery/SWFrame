//
//  ErrorExt.swift
//  SwiftFrame
//
//  Created by 杨建祥 on 2020/4/11.
//

import UIKit

public enum AppError: Error {
    case network
    case server
    case empty
}

public extension Error {
    
    var image: UIImage {
        guard let error = self as? AppError else { return .serverError }
        switch error {
        case .network:
            return .networkError
        case .server:
            return .serverError
        case .empty:
            return .serverError
        }
    }

    var title: String {
        guard let error = self as? AppError else { return "" }
        switch error {
        case .network:
            return "网络错误"
        case .server:
            return "服务异常"
        case .empty:
            return "数据为空"
        }
    }

    var message: String {
        guard let error = self as? AppError else { return self.localizedDescription }
        switch error {
        case .network:
            return "亲，请检查一下网络后再试试吧"
        case .server:
            return "亲，数据异常，请稍后重试"
        case .empty:
            return "亲，当前无数据，请稍后重试"
        }
    }
    
}
