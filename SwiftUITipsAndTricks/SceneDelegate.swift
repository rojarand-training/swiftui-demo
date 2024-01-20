//
//  SceneDelegate.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 19/01/2024.
//

import Foundation
import UIKit

class SceneDelegate: NSObject, ObservableObject, UIWindowSceneDelegate {
    static var window1: UIWindow?   // << contract of `UIWindowSceneDelegate`

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        Self.window1 = windowScene.keyWindow   // << store !!!
    }
}
