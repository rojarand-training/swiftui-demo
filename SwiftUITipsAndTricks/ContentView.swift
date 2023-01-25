//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        LoadableViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIViewController {
    
    func add(_ childViewController: UIViewController) {
        self.view.addSubview(childViewController.view)
        childViewController.willMove(toParent: self)
        self.addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.didMove(toParent: nil)
        self.view.removeFromSuperview()
    }
}

class LoadableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let action = UIAction(title: "Start loading") { [weak self] _ in
            let progressViewController = ProgressViewController()
            self?.add(progressViewController)
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                progressViewController.remove()
            }
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
}

class ProgressViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.startAnimating()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(progressView)
        self.view.backgroundColor = .white.withAlphaComponent(0.3)
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Progress will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Progress did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Progress will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Progress did disappear")
    }
}
