//
//  CustomUIView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 10/02/2023.
//

import UIKit

final class CustomUIView: UIView {
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        guard let view = loadView() else { return }
        view.frame = view.bounds
        self.addSubview(view)
        label.text = "I'am loaded"
    }
    
    private func loadView() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomUIView", bundle: bundle)
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
