//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MyVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyVC: UIViewController {

    override func loadView() {
        let view = UIView()// UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        self.view = view
        view.backgroundColor = .red
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate(
            [label.topAnchor.constraint(equalTo: view.topAnchor),
             label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        
        let button = UIButton(primaryAction: UIAction(title:"CLICK ME", handler: { [label] action in
            label.text = "Button tapped"
        }))
        button.addTarget(nil, action: #selector(onButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        //button.setTitle("Click me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [button.topAnchor.constraint(equalTo: label.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        self.view = view
    }
    
    @objc private func onButtonTapped() {
        print("On button tapped")
    }
}
