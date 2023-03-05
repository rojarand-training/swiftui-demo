//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import UIKit

protocol TextView: AnyObject {
    func show(text: String)
}

@MainActor protocol TextPresenter {
    func generateTextAsync()
    func generateTextSync()
}

@propertyWrapper struct WeakWrapper<T:AnyObject> {
    
    weak var weakValue: T?
    
    var wrappedValue: T {
        set {
            weakValue = newValue
        }
        get {
            weakValue!
        }
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

@MainActor class TextPresenterImpl<TV: TextView>: TextPresenter {
    
    @WeakWrapper var textView: TV
    
    init(textView: TV) {
        self.textView = textView
    }
    
    func generateTextAsync() {
        Task {
            let randomNumber = Int.random(in: (1...100))
            try await Task.sleep(nanoseconds: 2_000_000_000)
            _textView.weakValue?.show(text: "\(randomNumber)")
        }
    }
    
    func generateTextSync() {
        let randomNumber = Int.random(in: (1...100))
        textView.show(text: "\(randomNumber)")
    }
}

class TextViewControllerImpl: UIViewController, TextView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var generateTextButton: UIButton = {
        let primaryAction = UIAction(title:"Generate Text",
                                     handler: { [weak self] action in
            self?.presenter.generateTextAsync()
        })
        let button = UIButton(primaryAction: primaryAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextControllerButton: UIButton = {
        let primaryAction = UIAction(title:"Go deeper",
                                     handler: { [weak self] action in
            self?.navigationController?.show(TextViewControllerImpl(), sender: nil)
        })
        let button = UIButton(primaryAction: primaryAction)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var presenter: TextPresenter!
    
    deinit {
        print("Dealocation vc with text: \(label.text ?? "")")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TextPresenterImpl(textView: self)
        
        self.view.addSubview(label)
        self.view.addSubview(generateTextButton)
        self.view.addSubview(nextControllerButton)
        
        let labelContraints = [
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ]
        
        let generateTextButtonContraints = [
            generateTextButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            generateTextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ]
        
        let nextControllerButtonContraints = [
            nextControllerButton.topAnchor.constraint(equalTo: generateTextButton.bottomAnchor, constant: 10),
            nextControllerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(labelContraints +
                                    generateTextButtonContraints +
                                    nextControllerButtonContraints)
    }
    
    func show(text: String) {
        label.text = text
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let navController = UINavigationController()
        navController.pushViewController(TextViewControllerImpl(), animated: false)
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
