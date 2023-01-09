//
//  XibViewController.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 09/01/2023.
//

import UIKit

class XibViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "I'm contstructed from xib"
    }
}
