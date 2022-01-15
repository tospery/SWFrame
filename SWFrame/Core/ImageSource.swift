//
//  ImageSource.swift
//  SWFrame
//
//  Created by liaoya on 2022/1/12.
//

import UIKit

public protocol ImageSource {

}

extension URL: ImageSource {}
extension UIImage: ImageSource {}
