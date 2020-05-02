//
//  ImageCacheExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/5/3.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import Kingfisher

extension ImageCache: ReactiveCompatible {}
public extension Reactive where Base: ImageCache {
    func cacheSize() -> Observable<Int> {
        return Single.create { single in
            self.base.calculateDiskCacheSize { size in
                single(.success(Int(size)))
            }
            return Disposables.create {}
        }.asObservable()
    }
    
    public func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create {}
        }.asObservable()
    }
}
