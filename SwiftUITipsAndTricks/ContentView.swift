//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


class MyViewController: UIViewController {
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tv)
        return tv
    }()
    
    private lazy var image: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "multiply.circle.fill"))
        img.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(img)
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate(makeConstraints())
        
        let initialText = "A lot of text"
        textView.text = initialText.reduce(initialText, { partialResult, char in
            partialResult + " " + partialResult + " "
        })
    }
    
    override func viewDidLayoutSubviews() {
        let exclusionTextFrame = UIBezierPath(rect: image.frame)
        textView.textContainer.exclusionPaths = [exclusionTextFrame]
    }
    
    private func makeConstraints() -> [NSLayoutConstraint] {
        [
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
        ]
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
