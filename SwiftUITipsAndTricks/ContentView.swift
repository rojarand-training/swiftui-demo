//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class MyRedView: UIView {
    
    private var numberOfTaps = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not expected to be created via IB")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 100+numberOfTaps, height: 100+numberOfTaps)
    }
    
    @objc func onTap() {
        numberOfTaps += 5
        invalidateIntrinsicContentSize()
    }
}

class VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        let v = MyRedView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(v)
        
        NSLayoutConstraint.activate([
         //   v.heightAnchor.constraint(equalToConstant: 100),
            v.widthAnchor.constraint(equalToConstant: 200),
            v.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            v.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        VC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
