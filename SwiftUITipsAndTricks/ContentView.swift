//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class VC: UIViewController {
    
    override func viewDidLoad() {
        let blueBackgroundView = UIView(frame: self.view.bounds)
        blueBackgroundView.backgroundColor = .blue
        blueBackgroundView.translatesAutoresizingMaskIntoConstraints = true
        blueBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blueBackgroundView)
        
        let redForegroundView = UIView(frame: self.view.bounds)
        redForegroundView.backgroundColor = .red
        redForegroundView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(redForegroundView)

        super.viewDidLoad()
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
