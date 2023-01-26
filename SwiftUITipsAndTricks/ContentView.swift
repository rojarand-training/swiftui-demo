//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: UIViewControllerRepresentable {
    let product: Product
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ProductViewController(product: product)
    }
   
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(product: Product())
    }
}


struct Product {
   let name = "Shampoo"
}

class ProductViewController: UIViewController {
    private let product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)//call super
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Can not create the ProductViewController from a story board")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Product name: \(product.name)"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
