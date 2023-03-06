//
//  SceneDelegate.swift
//  СookBook
//
//  Created by Alex on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
//        let startVC = StartViewController()
//        let navigation = UINavigationController(rootViewController: startVC)
//        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        window?.rootViewController = RecipeViewController()
    }

//    func configureHomeController() -> UIViewController {
//        let recipeNavVC = UINavigationController(rootViewController: RecipeViewController())
//        return recipeNavVC
//    }
}
