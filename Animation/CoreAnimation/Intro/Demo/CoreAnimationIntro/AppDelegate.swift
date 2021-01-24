//
//  AppDelegate.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
//        let navigationController = UINavigationController(rootViewController: TableViewController())
//        window?.rootViewController = navigationController
//        window?.rootViewController = FlyViewController()
//        window?.rootViewController = RotateViewController()
        window?.rootViewController = ShadowViewController()
//        window?.rootViewController = TestViewController()
        return true
    }

}

