//
//  UITableViewCell+Rx.swift
//  SWFrame
//
//  Created by liaoya on 2021/6/10.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UITableViewCell {
    
    var accessoryType: Binder<UITableViewCell.AccessoryType> {
        return Binder(self.base) { cell, accessoryType in
            cell.accessoryType = accessoryType
        }
    }

}
