//
//  SceneDelegate.swift
//  SunlightNewArchitectureIOS
//
//  Created by lorenc_D_K on 14.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewController = UINavigationController(rootViewController: StartViewController())
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

