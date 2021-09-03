//
//  AppDelegate.swift
//  SimpleInsert
//
//  Created by Rasmusson, Jonathan on 2021-09-03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

//        let navigationController = UINavigationController(rootViewController: ViewController())
//        let navigationController = UINavigationController(rootViewController: SectionsViewController())
        let navigationController = UINavigationController(rootViewController: AppendViewController())

        window?.rootViewController = navigationController
        return true
    }

}
