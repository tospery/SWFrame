//
//  TableViewController.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/7.
//

import UIKit
import URLNavigator

open class TableViewController: ScrollViewController {
    
    public var tableView: UITableView!
    
    required public init(_ navigator: NavigatorType, _ reactor: BaseViewReactor) {
        super.init(navigator, reactor)
        self.tableView = (self.scrollView as! UITableView)
        self.tableView.separatorStyle = .none
        self.tableView.alwaysBounceVertical = true
        self.tableView.tableFooterView = .init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.theme.backgroundColor = themeService.attribute { $0.backgroundColor }
    }
}
