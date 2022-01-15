//
//  ViewController.swift
//  SWFrame
//
//  Created by tospery on 04/13/2020.
//  Copyright (c) 2020 tospery. All rights reserved.
//

import UIKit
import SWFrame

class ViewController: UIViewController {
    
    lazy var testView: UIView = {
        let view = UIView.init()
        view.width = 200
        view.height = 200
        view.backgroundColor = UIColor.red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.testView.borderPositions = [.top, .left]
//        let aaa = self.testView.borderPositions
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(self.testView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.testView.left = 50
        self.testView.top = 200
    }

}

