//
//  Animator.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 26/05/2023.
//

import Foundation
import UIKit

class MessageViewAnimator {
    typealias DefaultAnimationCompletion = (Bool) -> Void
    
    var showDuration: TimeInterval = 0.4
    var hideDuration: TimeInterval = 0.2
    var displayDuration: TimeInterval = 2.0
    private var hiddenOrHidingInProgress = false
    
    func show(messageView: UIView,
              above viewController: UIViewController,
              completeAnimation: @escaping DefaultAnimationCompletion) {
        
        embed(messageView, above: viewController)
        animateToShow(messageView, then: completeAnimation)
    }
    
    func hide(messageView: UIView,
              completeAnimation: @escaping DefaultAnimationCompletion) {
        startHideAnimation(for: messageView, with: completeAnimation)
    }
    
    private func animateToShow(_ messageView: UIView, then completion: @escaping DefaultAnimationCompletion) {
        startShowAnimation(for: messageView, whenDone: self.scheduleHiding(for: messageView, with: completion))
    }
    
    private func startShowAnimation(for messageView: UIView,
                                    whenDone showCompletion: @autoclosure @escaping () -> Void) {
        hiddenOrHidingInProgress = false
        messageView.transform = CGAffineTransform(translationX: 0, y: -messageView.frame.height)
        UIView.animate(withDuration: showDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.0,
                       options: [.beginFromCurrentState, .curveLinear, .allowUserInteraction],
                       animations: {
            messageView.transform = .identity
        }, completion: { _ in
            showCompletion()
        })
    }
    
    private func scheduleHiding(for messageView: UIView, with animationCompletion: @escaping DefaultAnimationCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now()+displayDuration) {
            self.startHideAnimation(for: messageView, with: animationCompletion)
        }
    }
    
    private func startHideAnimation(for messageView: UIView, with animationCompletion: @escaping DefaultAnimationCompletion) {
        guard !hiddenOrHidingInProgress else { return }
        hiddenOrHidingInProgress = true
        UIView.animate(withDuration: hideDuration,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveEaseIn], animations: {
            messageView.transform = CGAffineTransform(translationX: 0, y: -messageView.frame.height)
        }, completion: { completed in
            messageView.superview?.removeFromSuperview()
            animationCompletion(completed)
        })
    }
    
    private func embed(_ messageView: UIView, above viewController: UIViewController) {
        let maskingView = UIView()
        maskingView.translatesAutoresizingMaskIntoConstraints = false
        var viewControllerView: UIView
        if let navigationController = viewController.navigationController {
            viewControllerView = navigationController.view
            navigationController.view.insertSubview(maskingView, belowSubview: navigationController.navigationBar)
            //make.top.equalTo(filtersView.snp.bottom)
            NSLayoutConstraint.activate([
                maskingView.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor),
                maskingView.trailingAnchor.constraint(equalTo: viewControllerView.trailingAnchor),
                maskingView.leadingAnchor.constraint(equalTo: viewControllerView.leadingAnchor),
                maskingView.bottomAnchor.constraint(equalTo: viewControllerView.bottomAnchor)
            ])
        } else {
            viewControllerView = viewController.view
            viewControllerView.addSubview(maskingView)
            NSLayoutConstraint.activate([
                maskingView.topAnchor.constraint(equalTo: viewControllerView.topAnchor),
                maskingView.trailingAnchor.constraint(equalTo: viewControllerView.trailingAnchor),
                maskingView.leadingAnchor.constraint(equalTo: viewControllerView.leadingAnchor),
                maskingView.bottomAnchor.constraint(equalTo: viewControllerView.bottomAnchor)
            ])
        }
        maskingView.clipsToBounds = true
        maskingView.addSubview(messageView)
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: maskingView.topAnchor),
            messageView.trailingAnchor.constraint(equalTo: maskingView.trailingAnchor),
            messageView.leadingAnchor.constraint(equalTo: maskingView.leadingAnchor)
        ])
        viewControllerView.layoutIfNeeded()
    }
}

