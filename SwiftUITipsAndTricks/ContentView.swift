//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct TextCapitalizationTrait: UITraitDefinition {
    static var defaultValue = false
}

extension UITraitCollection {
    var useBoldText: Bool {
        get {
            self[TextCapitalizationTrait.self]
        }
    }
}

extension UIMutableTraits {
    var useBoldText: Bool {
        get {
            self[TextCapitalizationTrait.self]
        }
        set {
            self[TextCapitalizationTrait.self] = newValue
        }
    }
}

class MyLabel: UILabel {
    override var text: String? {
        get { super.text }
        set {
            super.text = traitCollection.useBoldText ? newValue?.uppercased() : newValue
        }
    }
}

class MyViewController: UIViewController {
    
    private let label = MyLabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        NSLayoutConstraint.activate(
            [label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)]
        )
        traitOverrides.useBoldText = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        label.text = "Hello"
    }
}

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        MyViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
