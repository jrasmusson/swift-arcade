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

        let homeNC = UINavigationController(rootViewController: homeVC)
        let myNC = UINavigationController(rootViewController: myVC)
        let postNC = UINavigationController(rootViewController: postVC)
        let favNC = UINavigationController(rootViewController: favVC)
        let messageNC = UINavigationController(rootViewController: messageVC)

        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [homeNC, myNC, postNC, favNC, messageNC]
        tabBarController.viewControllers = [ViewController()]

        window?.rootViewController = tabBarController

        return true
    }

}

