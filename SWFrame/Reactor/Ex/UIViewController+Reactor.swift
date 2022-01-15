//
//  UIViewController+Ex.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

public extension UIViewController {
    
    struct RuntimeKey {
        static let automaticallySetModalPresentationStyleKey = UnsafeRawPointer.init(bitPattern: "automaticallySetModalPresentationStyleKey".hashValue)
    }
    
    var automaticallySetModalPresentationStyle: Bool? {
        get {
            objc_getAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!) as? Bool
        }
        set {
            objc_setAssociatedObject(self, RuntimeKey.automaticallySetModalPresentationStyleKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    var isPresented: Bool {
        var viewController = self
        if let navigationController = self.navigationController {
            if navigationController.rootViewController != self {
                return false
            }
            viewController = navigationController
        }
        return viewController.presentingViewController?.presentedViewController == viewController
    }
    
    /** 获取和自身处于同一个UINavigationController里的上一个UIViewController */
    var previous: UIViewController? {
        if let viewControllers = self.navigationController?.viewControllers,
           let index = viewControllers.firstIndex(of: self),
            index > 0 {
            return viewControllers[index - 1]
        }
        return nil
    }
    
    @objc func swf_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            var need = true
            if let _ = self as? UIImagePickerController {
                need = false
            } else if let _ = self as? UIAlertController {
                need = false
            } else {
                let className = viewControllerToPresent.className
                switch className {
                case "PopupDialog",
                     "SideMenuNavigationController":
                    need = false
                default:
                    break
                }
            }
            if need {
                if let auto = self.automaticallySetModalPresentationStyle, auto == false {
                    need = false
                }
            }
            if need {
                viewControllerToPresent.modalPresentationStyle = .fullScreen
            }
        }
        self.swf_present(viewControllerToPresent, animated: flag, completion: completion)
    }

}

