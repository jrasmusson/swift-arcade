//
//  AppDelegate.swift
//  Spotify
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-13.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .spotifyBlack
        window?.makeKeyAndVisible()
        
        let navigatorController = UINavigationController(rootViewController: TitleBarController())
        window?.rootViewController = navigatorController

//        window?.rootViewController = HomeController()

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack

        return true
    }


}

