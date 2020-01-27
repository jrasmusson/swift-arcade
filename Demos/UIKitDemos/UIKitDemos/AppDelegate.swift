//
//  AppDelegate.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()

            let navigationDemos = [
                Lab(name: "Modal", viewController: ModalNavigation()),
                Lab(name: "Container", viewController: ContainerNavigation()),
    //            Lab(name: "UITabViewController [viewControllers]", viewController: CHCRImage()),
            ]

            //
            // Top level
            //

            let navigationViewController = LabViewController(labs: navigationDemos, navBarTitle: "Navigation")

            let rootLabs = [
                Lab(name: "Navigation", viewController: navigationViewController),
            ]

            let rootViewController = LabViewController(labs: rootLabs, navBarTitle: "Swift Arcade Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.rootViewController = navigatorController

            return true
    }

}
