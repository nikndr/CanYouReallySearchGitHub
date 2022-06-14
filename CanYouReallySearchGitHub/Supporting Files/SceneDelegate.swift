//
//  SceneDelegate.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 11.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController(rootViewController: RepositoryListViewController())
        window.rootViewController = rootViewController
        window.windowScene = windowScene
        self.window = window

        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
