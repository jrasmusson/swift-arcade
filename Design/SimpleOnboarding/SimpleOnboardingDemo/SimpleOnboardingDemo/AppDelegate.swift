//
//  AppDelegate.swift
//  SimpleOnboardingDemo
//
//  Created by jrasmusson on 2021-01-08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
//        window?.rootViewController = ViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        window?.rootViewController = DemoViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        window?.rootViewController = LoginViewController()

        return true
    }

}

