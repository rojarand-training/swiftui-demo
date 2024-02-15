//
//  FrameAnimator.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 15/02/2024.
//

import UIKit

class FrameAnimator {
    
    private var animator: UIViewPropertyAnimator?
    private let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func animate(targetFrame frame: CGRect) {
        animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut) { [weak self] in
            self?.view.frame = frame
        }
        animator?.startAnimation(afterDelay: 1.0)
    }
    
    func cancelAnimation() {
        animator?.stopAnimation(true)
    }
}
