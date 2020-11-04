//
//  UITableViewExt.swift
//  iOSFrame
//
//  Created by 杨建祥 on 2020/5/1.
//

import UIKit

public extension UITableView {
    
    func emptyCell(for indexPath: IndexPath) -> UITableViewCell {
        let identifier = "iOSFrame.UITableView.emptyCell"
        self.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.isHidden = true
        return cell
    }
    
}
