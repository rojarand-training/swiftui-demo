//
//  SBViewController.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 08/12/2023.
//

import UIKit

class SBViewController: UIViewController {

    @IBOutlet weak var distanceBetweenTopAndBottomLabels: NSLayoutConstraint!
    
    @IBAction func onButtonTouch(_ sender: UIButton) {
        distanceBetweenTopAndBottomLabels.constant = 1000
        distanceBetweenTopAndBottomLabels.isActive.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
