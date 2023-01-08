//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import UIKit

struct ContentView: View {

    var body: some View {
        UIViewRepresentation()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UIViewRepresentation: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SampleViewController {
        return SampleViewController()
    }
    
    func updateUIViewController(_ uiViewController: SampleViewController, context: Context) {
    }
}

class SampleViewController: UIViewController {
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello from UIViewController"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(infoLabel)
        NSLayoutConstraint.activate(
            [infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             infoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)]
        )
        self.view.backgroundColor = .orange
    }
}
