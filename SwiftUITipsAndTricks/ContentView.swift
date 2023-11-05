//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


var window2: UIWindow?

final class Win1VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        let button = UIButton(primaryAction: UIAction(title: "Open Win2", handler: { [unowned self] _ in
            self.changeWindow()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let alert = UIAlertController(title: "Hello", message: "Hi there", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] uiAlertAction in
        }
        alert.addAction(alertAction)
        present(alert, animated: true) //show(alert, sender:nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.changeWindow()
        }
    }
    
    private func changeWindow() {
        if window2 == nil {
            if let currentWindowScene = UIApplication.shared.connectedScenes.first as?  UIWindowScene {
                let window = UIWindow(windowScene: currentWindowScene)
                window.backgroundColor = .blue
                window.rootViewController = Win2VC()
                window2 = window
            }
        }
        window2?.makeKeyAndVisible()
    }
}

final class Win2VC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        let button = UIButton(primaryAction: UIAction(title: "Open Win1", handler: { _ in
            SceneDelegate.window1?.makeKeyAndVisible()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

struct Win1: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        Win1VC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

final class ContentViewModel: ObservableObject {
    @Published var showWindow1 = false
}

struct ContentView: View {

    @EnvironmentObject private var appDelegate: AppDelegate
    @EnvironmentObject var sceneDelegate: SceneDelegate
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        if vm.showWindow1 {
            Win1()
        } else {
            Button("Show Win1") {
                vm.showWindow1 = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

