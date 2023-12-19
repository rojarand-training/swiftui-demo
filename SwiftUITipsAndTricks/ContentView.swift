//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData


final class MyVC: UIViewController {
    
    private var label : UILabel = {
        let lab = UILabel()
        lab.text = "HelloWorld"
        return lab
    }()
    
    private var labelGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0.0, 1.0]
        layer.zPosition = CGFloat.greatestFiniteMagnitude
        layer.startPoint = CGPoint(x: 0.0, y: 1.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        let baseColor: UIColor = .gray
        let startColor = baseColor.withAlphaComponent(0.3).cgColor
        let endColor = baseColor.withAlphaComponent(0.9).cgColor
        layer.colors = [startColor, endColor]
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.0
        layer.add(animation, forKey: nil)
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        
        label.layer.insertSublayer(labelGradientLayer, at: 0)
       
        /////////////////////////////
        /////////////////////////////
        /////////////////////////////
        
        let iView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        iView.center = view.center
        iView.backgroundColor = .yellow
        view.addSubview(iView)
        
        let gradientLayer = CAGradientLayer(layer: iView.layer)
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = iView.bounds
        iView.layer.insertSublayer(gradientLayer, at: 0)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.2]
        animation.toValue = [0.0, 0.9]
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: nil)
    }
    
    override func viewDidLayoutSubviews() {
        labelGradientLayer.frame = label.bounds
        labelGradientLayer.cornerRadius = 5
    }
    
    
}

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        MyVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
