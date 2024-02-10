//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


class _1AlignToViewAnchorVC: LayoutPresentationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "CoveringView to view.anchors"
    }
    
    override func createNextScreen() -> UIViewController {
        _2AlignToViewSafeAreaVC()
    }
    
    override func layoutCoveringView() {
        NSLayoutConstraint.activate([
            coveringView.topAnchor.constraint(equalTo: view.topAnchor),
            coveringView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coveringView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

class _2AlignToViewSafeAreaVC: LayoutPresentationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "CoveringView to view.safeAreaLayoutGuide"
    }
    
    override func createNextScreen() -> UIViewController {
        _3AlignToViewLayoutMarginsGuideVC()
    }
    
    override func layoutCoveringView() {
        coveringView.backgroundColor = .green
        NSLayoutConstraint.activate([
            coveringView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coveringView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            coveringView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

class _3AlignToViewLayoutMarginsGuideVC: LayoutPresentationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "CoveringView to view.layoutMarginsGuide"
    }
    
    override func createNextScreen() -> UIViewController {
        _4AlignToViewLayoutMarginsGuideWithInsetsVC()
    }
    
    override func layoutCoveringView() {
        NSLayoutConstraint.activate([
            coveringView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            coveringView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            coveringView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

class _4AlignToViewLayoutMarginsGuideWithInsetsVC: LayoutPresentationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "CoveringView to view.layoutMarginsGuide with insets"
        nextButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    override func createNextScreen() -> UIViewController {
        _5AlignToViewReadableContentGuideVC()
    }
    
    override func layoutCoveringView() {
        view.layoutMargins = UIEdgeInsets(top: 50, left: 20, bottom: 100, right: 60)
        NSLayoutConstraint.activate([
            coveringView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            coveringView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            coveringView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

class _5AlignToViewReadableContentGuideVC: LayoutPresentationBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "CoveringView to view.readableContentGuide"
    }
    
    override func createNextScreen() -> UIViewController {
        _1AlignToViewAnchorVC()
    }
    
    override func layoutCoveringView() {
        NSLayoutConstraint.activate([
            coveringView.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            coveringView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            coveringView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
        ])
    }
}

class LayoutPresentationBaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
    
    lazy var coveringView: UIView = {
        let coveringLayout = UIView()
        coveringLayout.backgroundColor = .orange
        coveringLayout.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coveringLayout)
        return coveringLayout
    }()
    
    lazy var brownRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let action = UIAction(title:"Go Next") { [weak self] _ in
            self?.navigateToNextScreen()
        }
        let button = UIButton(primaryAction: action)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Some information"
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    func navigateToNextScreen() {
        navigationController?.show(createNextScreen(), sender: self)
    }
    
    func createNextScreen() -> UIViewController {
        fatalError("To override")
    }
    
    func layoutCoveringView() {
        fatalError("To override")
    }
    
    func layoutNextButton() {
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func layoutLabel() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: nextButton.bottomAnchor),
        ])
    }
    
    func layoutRectangle() {
        NSLayoutConstraint.activate([
            brownRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brownRectangle.topAnchor.constraint(equalTo: coveringView.topAnchor),
            brownRectangle.widthAnchor.constraint(equalToConstant: 100),
            brownRectangle.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func setUpLayout() {
        view.backgroundColor = .blue
        view.addSubview(coveringView)
        layoutCoveringView()
        layoutRectangle()
        layoutNextButton()
        layoutLabel()
    }
}

final class LayoutLearningWizard: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([_1AlignToViewAnchorVC()], animated: true)
    }
}

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        LayoutLearningWizard()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .ignoresSafeArea()
    }
}
