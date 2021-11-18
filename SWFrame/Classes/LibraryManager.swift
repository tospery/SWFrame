//
//  LibraryManager.swift
//  SWFrame
//
//  Created by liaoya on 2021/11/18.
//

import UIKit

final public class LibraryManager: NSObject {
    
    public static let shared = LibraryManager()
    
    override init() {
        super.init()
    }
    
    public func setup() {
        // [self setupToast];
    }
    
//    - (void)setupToast {
//        [CSToastManager setQueueEnabled:YES];
//        [CSToastManager setDefaultPosition:CSToastPositionCenter];
//    }
    
}
