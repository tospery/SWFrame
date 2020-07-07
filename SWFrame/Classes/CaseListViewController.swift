//
//  CaseListViewController.swift
//  SWFrame
//
//  Created by liaoya on 2020/7/7.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ObjectMapper

open class CaseListViewController: CaseBaseViewController {
    
    let reuseID = "CaseCell"
    let disposeBag = DisposeBag()
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<CaseSection> = {
        return .init(configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseID, for: indexPath)
            cell.textLabel?.font = .systemFont(ofSize: 15)
            cell.textLabel?.textColor = .darkText
            cell.textLabel?.text = item.name
            return cell
        })
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseID)
        
        var sections: [CaseSection] = []
        var name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        name = name.replacingOccurrences(of: "ViewController", with: "")
        if let path = Bundle.main.path(forResource: name, ofType: "json"),
            let string = try? String(contentsOfFile: path, encoding: .utf8),
            let cases = Array<Case>(JSONString: string) {
            sections = [
                CaseSection(items: cases)
            ]
        }
        
        Observable.just(sections)
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        self.tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                let section = sections[indexPath.section]
                let item = section.items[indexPath.row]
                
                let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
                let classname = namespace + "." + item.forward + "ViewController"
                if let cls = NSClassFromString(classname) as? UIViewController.Type {
                    let vc = cls.init()
                    vc.navigationItem.title = item.name
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let sel = NSSelectorFromString(item.forward + ":")
                    if self.responds(to: sel) {
                        self.perform(sel, with: item.parameters)
                    }
                }})
            .disposed(by: self.disposeBag)
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
    }

}

extension CaseListViewController : UITableViewDelegate {
    
}
