//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


final class ViewControllerWithCustomUIToolbarBar: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            print(UIApplication.shared.statusBarFrame.height)//44 for iPhone x, 20 for other iPhones
            navigationController?.navigationBar.barTintColor = .red

            view.backgroundColor = .red
            //let toolBar = UIToolbar()
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            var items = [UIBarButtonItem]()
            items.append(
                UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
            )
            items.append(
                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(item1Tapped))
            )
            toolBar.setItems(items, animated: true)
            toolBar.tintColor = .red
            view.addSubview(toolBar)

            /*
            toolBar.translatesAutoresizingMaskIntoConstraints = false


            if #available(iOS 11.0, *) {
                let guide = self.view.safeAreaLayoutGuide
                toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
                toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
                toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
                toolBar.heightAnchor.constraint(equalToConstant: 35).isActive = true

            }
            else {
                NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
                NSLayoutConstraint(item: toolBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
                NSLayoutConstraint(item: toolBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true

                toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
            }*/

        }
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        // Set constraints for the toolbar
        toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        toolbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add items to the toolbar
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let item1 = UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: #selector(item1Tapped))
        let item2 = UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: #selector(item2Tapped))
        
        toolbar.items = [item1, flexibleSpace, item2]
    }*/
    
    @objc func item1Tapped() {
        // Handle item 1 tap
        print("Item 1 tapped")
        dismiss(animated: true)
    }
    
    @objc func item2Tapped() {
        // Handle item 2 tap
        print("Item 2 tapped")
        dismiss(animated: true)
    }
}

final class ViewControllerWithCustomNavigationBar: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = removeNavItem
        navigationItem.rightBarButtonItem = removeNavItem
        navigationItem.title = "Hello there"
        view.backgroundColor = .blue
        
        let topLabel = UILabel()
        topLabel.text = "I'm very top title label"
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
        
        let bottomLabel = UILabel()
        bottomLabel.text = "I'm very bottom title label"
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])
    }
    
    private var removeNavItem: UIBarButtonItem {
        UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(navigateBack(_:)))
    }
    
    @objc func navigateBack(_ sender: Any?) {
        
    }
}

final class SampleNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        show(ViewControllerWithCustomNavigationBar(), sender: nil)
    }
}

final class PresentingViewController: UIViewController {
    
    private let viewControllerToBePresented: UIViewController
    init(nextViewController: UIViewController) {
        self.viewControllerToBePresented = nextViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let action = UIAction(title: "Open a controller modaly") { [weak self] _ in
            if let self {
                self.present(self.viewControllerToBePresented, animated: true)
            }
        }
        let button = UIButton(primaryAction: action)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

struct UINavigationControlerExample: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        PresentingViewController(nextViewController: SampleNavigationController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct UIToolbarViewControlerExample: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        PresentingViewController(nextViewController: ViewControllerWithCustomUIToolbarBar())
//        ViewControllerWithCustomUIToolbarBar()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Toolbar presentation view example")
                NavigationLink("UIToolbar example", destination: UIToolbarViewControlerExample())
                NavigationLink("Navigation controller example", destination: UINavigationControlerExample())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
