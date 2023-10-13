//
//  ContentView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 30/12/2022.
//

import SwiftUI
import CoreData

class SampleViewController: UIViewController {
    
    private var labelUnderTest: UILabel!
    private var actualFrameSizeOfLabelUnderTest: UILabel!
    private var bestFrameSizeOfLabelUnderTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUnderTest = UILabel(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        labelUnderTest.text = "Hello World"
        self.view.addSubview(labelUnderTest)
        
        let labelUnderTest2 = UILabel(frame: CGRect(x: labelUnderTest.frame.maxY+10, y: 10, width: 30, height: 30))
        labelUnderTest2.text = "Hello World"
        self.view.addSubview(labelUnderTest2)
        
        actualFrameSizeOfLabelUnderTest = UILabel(frame: CGRect(x: 10, y: labelUnderTest.frame.maxY+5, width: 200, height: 30))
        self.view.addSubview(actualFrameSizeOfLabelUnderTest)
        
        let sizeThatFitsToHoldLabelUnderTest = labelUnderTest.sizeThatFits(self.view.frame.size)
        
        bestFrameSizeOfLabelUnderTest = UILabel(frame: CGRect(x: 10, y: actualFrameSizeOfLabelUnderTest.frame.maxY+5, width: 200, height: 30))
        bestFrameSizeOfLabelUnderTest.text = "\(sizeThatFitsToHoldLabelUnderTest)"
        self.view.addSubview(bestFrameSizeOfLabelUnderTest)
        
        let button = UIButton(frame: CGRect(x: 10, y: bestFrameSizeOfLabelUnderTest.frame.maxY+5, width: 200, height: 30))
        button.backgroundColor = .cyan
        button.setTitle("Recalc", for: .normal)
        
        button.addAction(UIAction(handler: { [unowned self] action in
            self.labelUnderTest.sizeToFit()
            self.showFrame()
        }), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showFrame()
    }
    
    private func showFrame() {
        actualFrameSizeOfLabelUnderTest.text = "\(labelUnderTest.frame.size)"
    }
}

struct SampleViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SampleViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView: View {

    var body: some View {
        SampleViewControllerRepresentable()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
