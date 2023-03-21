//
//  AnimationViewController.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 22/03/2023.
//

import Foundation
import UIKit

class AnimationViewController: UIViewController {
    
    private var dark = false
    private lazy var label: UILabel = {
        let view = UILabel()
        view.text = "Text"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let runAnimation = UIAction(title:"Change text color", handler: { [unowned self] action in self.runAnimation()
        })
        let view = UIButton(primaryAction: runAnimation)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
        self.view.addSubview(button)
        
        let constraints = [
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
   
    private func runAnimation() {
        if dark {
            label.moveRight(by: 50)
                .and(.changeAlpha(of: label, to: 0.6))
                .and(.moveDown(view: label, by: 50))
                .then(.changeTextColor(of: label, to: .black, duration: 1.0))
                //.then(.changeBackgroundColor(of: label, to: .red, duration: 1.0))
                .then(.moveLeft(view: label, by: 50))
                .then(.moveUp(view: label, by: 50))
                .start()
             
        } else {
            label.moveLeft(by: 50)
                .and(.changeAlpha(of: label, to: 1.0))
                .and(.moveUp(view: label, by: 50))
                .then(.changeTextColor(of: label, to: .red, duration: 1.0))
                //.then(.changeBackgroundColor(of: label, to: .green, duration: 1.0))
                .then(.moveRight(view: label, by: 50))
                .then(.moveDown(view: label, by: 50))
                .start()
        }
        dark.toggle()
    }
}

extension UIView {
    func moveRight(by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        .moveRight(view: self, by: offset, duration: duration)
    }
    
    func moveLeft(by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        .moveLeft(view: self, by: offset, duration: duration)
    }
    
    func changeTextColor(to uiColor: UIColor, duration: TimeInterval = 0.5) -> Animation {
        .changeTextColor(of: self, to: uiColor, duration: duration)
    }
    
    func changeBackgroundColor(to uiColor: UIColor, duration: TimeInterval = 0.5) -> Animation {
        .changeBackgroundColor(of: self, to: uiColor, duration: duration)
    }
}

extension Animation {
    static func moveRight(view: UIView, by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        Animation(view: view, duration: duration) { view in
            view.frame.origin.x += offset
        }
    }
    
    static func moveLeft(view: UIView, by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        Animation(view: view, duration: duration) { view in
            view.frame.origin.x -= offset
        }
    }
    
    static func moveUp(view: UIView, by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        Animation(view: view, duration: duration) { view in
            view.frame.origin.y -= offset
        }
    }
    
    static func moveDown(view: UIView, by offset: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        Animation(view: view, duration: duration) { view in
            view.frame.origin.y += offset
        }
    }
    
    static func changeAlpha(of view: UIView, to alhpa: CGFloat, duration: TimeInterval = 0.5) -> Animation {
        Animation(view: view, duration: duration) { view in
            view.alpha = alhpa
        }
    }
    
    static func changeTextColor(of view: UIView, to uiColor: UIColor, duration: TimeInterval = 0.5) -> Animation {
        Transition(view: view, duration: duration) { view in
            if let label = view as? UILabel {
                label.textColor = uiColor
            }
        }
    }
    
    static func changeBackgroundColor(of view: UIView, to uiColor: UIColor, duration: TimeInterval = 0.5) -> Animation {
        Transition(view: view, duration: duration) { view in
            view.backgroundColor = uiColor
        }
    }
}

class Animation {
    fileprivate weak var view: UIView?
    fileprivate let duration: TimeInterval
    fileprivate let animation:(UIView) -> Void
    fileprivate var followingAnimation: Animation?
    fileprivate var parallelAnimation: Animation?
    
    init(view: UIView?,
         duration: TimeInterval,
         animation: @escaping (UIView) -> Void) {
        self.view = view
        self.duration = duration
        self.animation = animation
    }
    
    private var lastAnimation: Animation {
        var runner = self
        while let r = (runner.followingAnimation ?? runner.parallelAnimation) {
            runner = r
        }
        return runner
    }
    
    func then(withDuration duration: TimeInterval = 0.5,
              animation: @escaping (UIView) -> Void) -> Animation {
        then(Animation(view: view, duration: duration, animation: animation))
    }
    
    func then(_ animation: Animation) -> Animation {
        lastAnimation.followingAnimation = animation
        return self
    }
    
    func and(withDuration duration: TimeInterval = 0.5,
             animation: @escaping (UIView) -> Void) -> Animation {
        and(Animation(view: view, duration: duration, animation: animation))
    }
    
    func and(_ animation: Animation) -> Animation {
        lastAnimation.parallelAnimation = animation
        return self
    }
    
    func start() {
        UIView.animate(withDuration: duration) {
            guard let view = self.view else { return }
            self.animation(view)
            self.parallelAnimation?.start()
        } completion: { result in
            self.followingAnimation?.start()
        }
    }
}

class Transition: Animation {
   
    override func start() {
        guard let view = self.view else { return }
        UIView.transition(with: view, duration: duration, options: .transitionCrossDissolve) {
            self.animation(view)
            self.parallelAnimation?.start()
        } completion: { result in
            self.followingAnimation?.start()
        }
    }
}



extension UIView {
    
    func animate(withDuration duration: TimeInterval = 0.5, transition: @escaping (UIView) -> Void) -> Animation {
        Animation(view: self, duration: duration, animation: transition)
    }
}

extension UILabel {
    @discardableResult func changeTextColor(to uiColor: UIColor,
                                            duration: TimeInterval = 0.5) -> Self {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.textColor = uiColor
        } completion: { result in
            print("Change text color completion: \(result)")
        }
        return self
    }
    
    @discardableResult func changeBackgroundColor(to uiColor: UIColor,
                                                  duration: TimeInterval = 0.5) -> Self {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
            self.backgroundColor = uiColor
        } completion: { result in
            print("Change text color completion: \(result)")
        }
        return self
    }
}
