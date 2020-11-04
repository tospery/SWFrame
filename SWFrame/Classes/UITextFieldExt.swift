//
//  UITextFieldExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/4/26.
//

import UIKit
import QMUIKit
import RxSwift
import RxCocoa
import SwifterSwift

public extension UITextField {
    
}

public extension Reactive where Base: UITextField {
    
    var placeHolderColor: Binder<UIColor> {
        return Binder(self.base) { textField, color in
            textField.setPlaceHolderTextColor(color)
        }
    }
    
}
