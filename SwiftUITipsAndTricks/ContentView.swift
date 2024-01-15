//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class ParkingSummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        
        let stackView = UIStackView()
        stackView.backgroundColor = .yellow
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.distribution = /*.fillEqually*/.fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        
        scrollView.addSubview(stackView)
//        var x = scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        var x = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        x.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            x
            //stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        
//        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        stackView.isLayoutMarginsRelativeArrangement = true

        let image = UIImage(systemName: "stop")
        let imageView = UIImageView(image: image)
        
//        imageView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 60, right: 0)
//        imageView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 50, bottom: 50, trailing: 10)
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 160))
        spacerView.backgroundColor = .yellow
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(imageView)
        stackView.setCustomSpacing(100, after: imageView)
        
        var label = UILabel()
        label.text = "Helllo"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        stackView.addArrangedSubview(label)
        
        for i in 0..<30 {
            let childView = UILabel()
//            childView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 60, right: 0)
            childView.text = "Hello \(i)"
            childView.backgroundColor = .green
            stackView.addArrangedSubview(childView)
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(imageView)
            
        }
    }
    
}

final class HostViewControllerWithTransparentBorder: UIViewController {
    
    private let childViewController: UIViewController
    
    init(childViewController: UIViewController) {
        self.childViewController = childViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setUpLayout()
    }
    
    private func setUpLayout() {
        addChild(childViewController)
        childViewController.didMove(toParent: self)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let childView: UIView = childViewController.view
        view.addSubview(childView)
        
        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            childView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            childView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: verticalMargin),
            childView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: verticalMargin)
        ])
    }
    
    private var horizontalMargin: CGFloat {
        20.0
    }
    
    private var verticalMargin: CGFloat {
        20.0
    }
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        HostViewControllerWithTransparentBorder(childViewController: ParkingSummaryViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
