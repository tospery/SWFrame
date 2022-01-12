//
//  SWError.swift
//  SWFrame
//
//  Created by liaoya on 2021/1/5.
//

import Foundation
import RxSwift
import Moya

extension SWError {

    public var displayImage: UIImage? {
        if self.isNetwork {
            return UIImage.networkError
        } else if self.isServer {
            return UIImage.serverError
        } else if self.isListIsEmpty {
            return UIImage.emptyError
        } else if self.isNotLoginedIn {
            return UIImage.expireError
        }
        return nil
    }
    
}
