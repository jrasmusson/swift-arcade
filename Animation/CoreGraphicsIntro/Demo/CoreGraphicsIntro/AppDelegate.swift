//
//  AppDelegate.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let navigationController = UINavigationController(rootViewController: TableViewController())
//        let navigationController = UINavigationController(rootViewController: CoordinateSystemViewController())
//        let navigationController = UINavigationController(rootViewController: DrawRectViewController())
//        let navigationController = UINavigationController(rootViewController: LoadViaImageViewController())
        window?.rootViewController = navigationController
        
        return true
    }
}

