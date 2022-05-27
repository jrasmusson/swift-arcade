//
//  AppDelegate.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let homeVC = HomeViewController()
        let myVC = MyKijijiViewController()
        let postVC = PostViewController()
        let favVC = FavoritesViewController()
        let messageVC = MessagesViewController()

//        let homeNC = UINavigationController(rootViewController: homeVC)

//        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        myVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image1 = UIImage(systemName: "house", withConfiguration: configuration)
        let image2 = UIImage(systemName: "person", withConfiguration: configuration)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: image1, tag: 0)
        myVC.tabBarItem = UITabBarItem(title: "My Kijiji", image: image2, tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeVC, myVC]
//        tabBarController.viewControllers = [homeVC, myVC, postVC, favVC, messageVC]
//        tabBarController.viewControllers = [ViewController()]

        tabBarController.tabBar.tintColor = .systemGreen
        tabBarController.tabBar.isTranslucent = false

        window?.rootViewController = tabBarController

        return true
    }

}

