//
//  MessageView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 26/05/2023.
//

import Foundation
import UIKit

class MessageView: UIView {
    let backgroundView = UIView()
    let titleLabel = UILabel()
    var tapHandler: (() -> Void)? {
        didSet {
            installTapRecognizer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.backgroundColor = .orange
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        
        titleLabel.backgroundColor = .orange
        backgroundView.backgroundColor = titleLabel.backgroundColor
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = true
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(tapped))
    }()
    
    @objc private func tapped() {
        tapHandler?()
    }
    
    private func installTapRecognizer() {
        backgroundView.removeGestureRecognizer(tapRecognizer)
        if tapHandler != nil {
            backgroundView.addGestureRecognizer(tapRecognizer)
        }
    }
}
