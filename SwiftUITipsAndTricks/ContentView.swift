//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class ViewControllerWithSegmentedTab: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = createSegmentedView()
        self.view.backgroundColor = .blue
        
        let button = UIButton(frame: .zero, primaryAction: UIAction(title: "Move forward", handler: { [weak self] action in
            self?.navigationController?.show(NavButtonExample(), sender: nil)
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
        ])
        self.title = "Tab view"
    }
    
    private func createSegmentedView() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: ["First", "Second"])
        segmentedControl.addTarget(self, action: #selector(onTabValueChange(_:)), for: .valueChanged)
        return segmentedControl
    }
    
    @objc public func onTabValueChange(_ sender: UISegmentedControl) {
        print("Selected index: \(sender.selectedSegmentIndex)")
    }
}

class NavButtonExample: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.navigationItem.leftBarButtonItems = [removeNavItem, backNavItem]
        self.navigationItem.title = "***** PIS"
        self.navigationItem.rightBarButtonItems = [removeNavItem, backNavItem]
    }
    
    private var removeNavItem: UIBarButtonItem {
        UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(navigateBack(_:)))
    }
    
    private var backNavItem: UIBarButtonItem {
        UIBarButtonItem(title: "BCK", style: .plain, target: self, action: #selector(navigateBack(_:)))
    }
    
    @objc func navigateBack(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    
}

struct VCView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.backgroundColor = .red
        navigationController.setViewControllers([ViewControllerWithSegmentedTab()], animated: false)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView: View {

    var body: some View {
        VCView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
