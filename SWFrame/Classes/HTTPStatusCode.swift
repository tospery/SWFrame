////
////  HTTPStatusCode.swift
////  SWFrame
////
////  Created by liaoya on 2021/4/23.
////
//
//import Foundation
//
///// HTTP状态码: https://www.runoob.com/http/http-status-codes.html
//public struct HTTPStatusCode {
//
//    /// 信息，服务器收到请求，需要请求者继续执行操作
//    public enum Information: Int {
//        case `continue` = 100
//    }
//
//    /// 成功，操作被成功接收并处理
//    public enum Success: Int {
//        case ok = 200
//    }
//
//    /// 重定向，需要进一步的操作以完成请求
//    public enum Redirection: Int {
//        case multipleChoices = 300
//    }
//
//    /// 客户端错误，请求包含语法错误或无法完成请求
//    public enum Client: Int {
//        case badRequest     = 400
//        case unauthorized   = 401
//    }
//
//    /// 服务器错误，服务器在处理请求的过程中发生了错误
//    public enum Server: Int {
//        case internalServerError    = 500
//    }
//
//}
