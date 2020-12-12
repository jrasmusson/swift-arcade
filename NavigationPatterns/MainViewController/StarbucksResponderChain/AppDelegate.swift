//
//  AppDelegate.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.backgroundColor = .systemBackground
                    
            window?.rootViewController = MainViewController()
            
            return true
        }
}
