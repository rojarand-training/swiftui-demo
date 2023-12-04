//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class MyViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let action = UIAction(title: "Tap me") { [weak self] action in
            self?.handleButtonTapped()
        }
        func createButton() -> UIButton {
            if #available(iOS 15.0, *) {
                var buttonConfiguration = UIButton.Configuration.bordered()
                buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 50, trailing: 30)
                return UIButton(configuration: buttonConfiguration, primaryAction: action)
            } else {
                let oldStyleButton = UIButton(frame:.zero, primaryAction: action)
                oldStyleButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 30, bottom: 50, right: 30)
                return oldStyleButton
            }
        }
        let button = createButton()
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        NSLayoutConstraint.activate(makeLayoutConstraints())
    }
    
    private func makeLayoutConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
        constraints.append(button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor))
        return constraints
    }
    
    private func handleButtonTapped() {
        NSLog("Button tapped")
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        MyViewController()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
