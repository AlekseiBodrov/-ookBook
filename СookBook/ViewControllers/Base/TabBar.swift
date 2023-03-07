//
//  TabBar.swift
//  СookBook
//
//  Created by Admin on 1.03.23.
//

import UIKit

final class TabBar: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .specialRed
        setupVCs()
    }
    private func setupVCs() {
            viewControllers = [
                createNavController(for: MainViewController(), title: NSLocalizedString("Main", comment: ""), image: UIImage(systemName: "house")!),
                createNavController(for: FavoritesViewController(), title: NSLocalizedString("Favorite recipes", comment: ""), image: UIImage(systemName: "star")!)
            ]
        }
    private func createNavController(for rootViewController: UIViewController,
                                                     title: String,
                                                     image: UIImage) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           navController.navigationBar.prefersLargeTitles = true
           navController.modalPresentationStyle = .overCurrentContext
           rootViewController.navigationItem.title = title
           return navController
       }
}

