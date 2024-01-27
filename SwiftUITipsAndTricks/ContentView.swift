//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class FirstVC: UIViewController {
    
    lazy var firstRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToSecondVC)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(firstRectangleView)
        firstRectangleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstRectangleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstRectangleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 60),
            firstRectangleView.heightAnchor.constraint(equalToConstant: 120),
            firstRectangleView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    @objc private func goToSecondVC() {
        self.navigationController?.delegate = self
        self.navigationController?.show(SecondVC(), sender: nil)
    }
}

extension FirstVC: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransitionManager()
    }
}

final class SecondVC: UIViewController {
    
    lazy var secondRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(secondRectangleView)
        secondRectangleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondRectangleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondRectangleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            secondRectangleView.heightAnchor.constraint(equalToConstant: 160),
            secondRectangleView.widthAnchor.constraint(equalToConstant: 160),
        ])
        
        let label = UILabel();
        label.text = "SecondVC"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: secondRectangleView.bottomAnchor, constant: 50),
        ])
    }
}

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    private var operation = UINavigationController.Operation.push
        
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? FirstVC,
            let toViewController = transitionContext.viewController(forKey: .to) as? SecondVC
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        animateTransition(from: fromViewController, to: toViewController, with: transitionContext)
    }
    
    func animateTransition(from fromViewController: FirstVC, to toViewController: SecondVC, with context: UIViewControllerContextTransitioning) {
            switch operation {
            case .push:
                executeTransition(from: fromViewController, to: toViewController, with: context)
            case .pop:
                break
            default:
                break
            }
    }
    
    private func executeTransition(from fromViewController: FirstVC,
                                   to toViewController: SecondVC,
                                   with context: UIViewControllerContextTransitioning) {
        toViewController.view.layoutIfNeeded()
        
        let containerView = context.containerView
        
        let snapshotView = UIView()
        snapshotView.backgroundColor = fromViewController.firstRectangleView.backgroundColor
        
        let firstRectangleView = fromViewController.firstRectangleView
        snapshotView.frame = containerView.convert(firstRectangleView.frame, from: fromViewController.view)
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView)
        
        
        fromViewController.view.isHidden = true
        toViewController.view.isHidden = true
        
        let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            snapshotView.frame = containerView.convert(toViewController.secondRectangleView.frame,
                                                       from: toViewController.view)
        }

        animator.addCompletion { position in
            toViewController.view.isHidden = false
            fromViewController.view.isHidden = false
            snapshotView.removeFromSuperview()
            context.completeTransition(position == .end)
            fromViewController.navigationController?.delegate = nil
        }

        animator.startAnimation()
    }
}

extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            self.operation = operation
            if operation == .push {
                return self
            }
            return nil
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let firstVC = FirstVC()
        let navController = UINavigationController(rootViewController: firstVC)
        return navController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
