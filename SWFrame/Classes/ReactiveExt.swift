//
//  ReactiveExt.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import QMUIKit
import Toast_Swift
import ESPullToRefresh
import Kingfisher
import URLNavigator

// MARK: - UIView
public extension Reactive where Base: UIView {
    
//    var loading: Binder<Bool> {
//        return Binder(self.base) { view, loading in
//            view.isUserInteractionEnabled = !loading
//            loading ? view.makeToastActivity(.center) : view.hideToastActivity()
//        }
//    }
    
    var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { view, _ in
            view.setNeedsLayout()
        }
    }
    
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.borderColor = color
        }
    }
    
    var qmui_borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, color in
            view.qmui_borderColor = color
        }
    }
    
}

// MARK: - UIImageView
public extension Reactive where Base: UIImageView {
        
    var image: Binder<ImageSource?> {
        return Binder(self.base) { imageView, resource in
            imageView.isHidden = false
            if let image = resource as? UIImage {
                imageView.image = image
            } else if let url = resource as? URL {
                imageView.kf.setImage(with: url)
            } else {
                imageView.isHidden = true
            }
        }
    }
    
    func image(placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
        return Binder(self.base) { imageView, resource in
            imageView.kf.setImage(with: resource, placeholder: placeholder, options: options)
        }
    }
}

// MARK: - UICollectionView
public extension Reactive where Base: UICollectionView {
    func itemSelected<Section>(dataSource: CollectionViewSectionedDataSource<Section>) -> ControlEvent<Section.Item> {
        let source = self.itemSelected.map { indexPath in
            dataSource[indexPath]
        }
        return ControlEvent(events: source)
    }
}

// MARK: - BaseViewController
public extension Reactive where Base: BaseViewController {
    
    func loading(active: Bool = false, text: String? = nil) -> Binder<Bool> {
        return Binder(self.base) { viewController, loading in
            viewController.loading = loading
            if active, viewController.qmui_isViewLoadedAndVisible() {
                let view = viewController.view!
                view.isUserInteractionEnabled = !loading
                loading ? view.makeToastActivity(.center) : view.hideToastActivity()
            }
        }
    }
    
    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            if let error = error as? AppError, viewController.error == nil {
                switch error {
                case .expire:
                    viewController.navigator.present(UIApplication.shared.scheme + "://login", wrap: NavigationController.self)
                default:
                    break
                }
            }
            viewController.error = error
        }
    }
    
//    var emptyDataSetImageTintColorBinder: Binder<UIColor?> {
//        return Binder(self.base) { viewController, attr in
//            viewController.emptyDataSetImageTintColor.accept(attr)
//        }
//    }
    
//    var emptyDataSetTap: ControlEvent<Void> {
//        let source = self.base.emptyDataSetSubject.map{ _ in }
//        return ControlEvent(events: source)
//    }
    
}

// MARK: - ScrollViewController
public extension Reactive where Base: ScrollViewController {
    
    var noMoreData: Binder<Bool> {
        return Binder(self.base) { viewController, noMoreData in
            viewController.noMoreData = noMoreData
        }
    }
    
    var emptyDataSet: ControlEvent<Void> {
        let source = self.base.emptyDataSetSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var isRefreshing: Binder<Bool> {
        return Binder(self.base) { viewController, isRefreshing in
            if let scrollView = viewController.scrollView, !isRefreshing {
                scrollView.es.stopPullToRefresh()
            }
        }
    }
    
    var isLoadingMore: Binder<Bool> {
        return Binder(self.base) { viewController, isLoadingMore in
            if let scrollView = viewController.scrollView, !isLoadingMore {
                if !viewController.noMoreData {
                    scrollView.es.stopLoadingMore()
                } else {
                    scrollView.es.noticeNoMoreData()
                }
            }
        }
    }
    
    var refresh: ControlEvent<Void> {
        let source = self.base.refreshSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
    var loadMore: ControlEvent<Void> {
        let source = self.base.loadMoreSubject.map{ _ in }
        return ControlEvent(events: source)
    }
    
}

// MARK: - WebViewController
public extension Reactive where Base: WebViewController {
    var url: Binder<URL?> {
        return Binder(self.base) { viewController, url in
            viewController.url = url
        }
    }
}

// MARK: - ImageCache
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
