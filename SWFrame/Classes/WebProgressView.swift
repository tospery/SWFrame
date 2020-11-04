//
//  WebProgressView.swift
//  SWFrame
//
//  Created by 杨建祥 on 2020/4/20.
//

import UIKit

public class WebProgressView: UIView {
    
    let barAnimationDuration = 0.27
    let fadeAnimationDuration = 0.27
    let fadeOutDelay = 0.1
    
    var progress = 0.f
    
    public lazy var barView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        self.autoresizingMask = .flexibleWidth
        self.addSubview(self.barView)
        self.barView.frame = CGRect(x: 0, y: 0, width: 0, height: frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var frame: CGRect {
        didSet {
            super.frame = frame
            self.barView.frame = CGRect(x: 0, y: 0, width: 0, height: frame.size.height)
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: screenWidth, height: 1.5)
    }
    
    func progress(value: CGFloat, animated: Bool = false) {
        let isGrowing = value > 0.0
        var duration = (isGrowing && animated) ? self.barAnimationDuration : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            var frame = self.barView.frame
            frame.size.width = value * self.width
            self.barView.frame = frame
        }, completion: nil)
        
        if value >= 1.0 {
            duration = animated ? self.fadeAnimationDuration : 0.0
            UIView.animate(withDuration: duration, delay: self.fadeOutDelay, options: .curveEaseInOut, animations: {
                self.barView.alpha = 0.0
            }) { _ in
                var frame = self.barView.frame
                frame.size.width = 0
                self.barView.frame = frame
            }
        } else {
            duration = animated ? self.fadeAnimationDuration : 0.0
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                self.barView.alpha = 1.0
            }, completion: nil)
        }
    }
    
}
