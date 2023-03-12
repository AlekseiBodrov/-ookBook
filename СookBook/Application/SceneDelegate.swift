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
//        window?.rootViewController = CategoryViewController(categoryName: "dessert")

        //    window?.rootViewController = StepViewController(id: 715514)
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
    }
}
