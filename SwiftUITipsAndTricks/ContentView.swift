//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let action = UIAction(title: "Show banner") { _ in
            let animator = MessageViewAnimator()
            animator.displayDuration = 3.0
            let messageView = MessageView()
            messageView.titleLabel.text = "Hello\nWorld"
            messageView.titleLabel.backgroundColor = .orange
            animator.show(messageView: messageView, above: self) { _ in
                NSLog("Done")
            }
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
