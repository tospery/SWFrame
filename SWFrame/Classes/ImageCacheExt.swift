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
            self.base.calculateDiskStorageSize { result in
                switch result {
                case .success(let size):
                    single(.success(Int(size)))
                case .failure(_):
                    single(.success(0))
                }
            }
            return Disposables.create {}
        }.asObservable()
    }
    
    func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create {}
        }.asObservable()
    }
}
