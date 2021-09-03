//
//  AppDelegate.swift
//  LargeTitles
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let navigationController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigationController
        
        navigationController.navigationBar.prefersLargeTitles = true
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        
        navigationController.navigationBar.largeTitleTextAttributes = attrs

        return true
    }


}

