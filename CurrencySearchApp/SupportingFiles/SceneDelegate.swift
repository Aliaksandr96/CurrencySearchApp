//
//  SceneDelegate.swift
//  CurrencySearchApp
//
//  Created by Aliaksandr Hunko on 07/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
       let window = UIWindow(windowScene: windowScene)
        self.window = window
        let initialNavigationController = UINavigationController()
        window.rootViewController = initialNavigationController
        window.makeKeyAndVisible()
        
        let _ = CurrencyListRouter(navigationController: initialNavigationController)
        
    }
}

