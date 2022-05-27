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

        homeVC.setTabBarItem(imageName: "house", title: "Home")
        myVC.setTabBarItem(imageName: "person", title: "My Kijiji")

        let tabBarController = UITabBarController()

        tabBarController.viewControllers = [homeVC, myVC]
        tabBarController.tabBar.tintColor = .systemGreen
        tabBarController.tabBar.isTranslucent = false

        window?.rootViewController = tabBarController

        return true
    }
}
