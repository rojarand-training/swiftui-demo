//
//  Helpers.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 19/02/2024.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIWindow {
    static var current: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes.compactMap{ $0 as? UIWindowScene }.flatMap{ $0.windows }.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow ?? UIApplication.shared.windows.reversed().first { $0.windowLevel == UIWindow.Level.normal }
        }
    }
}

extension CGRect {
    
    public var foldedUp: CGRect {
        inset(by: UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0))
    }
    
    public var foldedDown: CGRect {
        inset(by: UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0))
    }
}
