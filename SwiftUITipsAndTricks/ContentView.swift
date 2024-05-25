//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

final class MyView: UIView {
    
    let tapHandler: (MyView) -> Void
    
    init(tapHandler: @escaping (MyView) -> Void) {
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTap() {
        tapHandler(self)
    }
}

final class ViewController: UIViewController {
    
    var nextZPosition: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let topLeftView = MyView { view in
            self.nextZPosition += 1.0
            view.layer.zPosition = self.nextZPosition
        }
        topLeftView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        topLeftView.backgroundColor = .yellow
        view.addSubview(topLeftView)
        
        let topRightView = MyView { view in
            self.nextZPosition += 1.0
            view.layer.zPosition = self.nextZPosition
        }
        topRightView.frame = CGRect(x: topLeftView.frame.maxX-20, y: topLeftView.frame.minY, width: 100, height: 100)
        topRightView.backgroundColor = .red
        view.addSubview(topRightView)
        
        let bottomLeftView = MyView { view in
            self.nextZPosition += 1.0
            view.layer.zPosition = self.nextZPosition
        }

        bottomLeftView.frame = CGRect(x: topLeftView.frame.minX, y: topLeftView.frame.maxY-20, width: 100, height: 100)
        bottomLeftView.backgroundColor = .green
        view.addSubview(bottomLeftView)

        let bottomRightView = MyView { view in
            self.nextZPosition += 1.0
            view.layer.zPosition = self.nextZPosition
            print(view.layer.zPosition)
        }

        bottomRightView.frame = CGRect(x: topRightView.frame.origin.x, y: bottomLeftView.frame.origin.y, width: 100, height: 100)
        bottomRightView.backgroundColor = .blue
        view.addSubview(bottomRightView)


    }
}

struct ContentView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
