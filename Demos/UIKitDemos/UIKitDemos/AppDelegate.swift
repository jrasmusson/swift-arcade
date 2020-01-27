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

            let containerLabs = [
                Lab(name: "NavigationController", viewController: NavigationController()),
                Lab(name: "TabViewController", viewController: TabBarViewController()),
//                Lab(name: "PageViewController", viewController: ContainerViewController()),
            ]

            let containerViewController = LabViewController(labs: containerLabs, navBarTitle: "Container")

            let navigationLabs = [
                Lab(name: "Modal", viewController: ModalNavigation()),
                Lab(name: "Container", viewController: containerViewController),
                Lab(name: "Custom", viewController: ContainerViewController()),
            ]


            //
            // Top level
            //

            let navigationViewController = LabViewController(labs: navigationLabs, navBarTitle: "Navigation")

            let rootLabs = [
                Lab(name: "Navigation", viewController: navigationViewController),
            ]

            let rootViewController = LabViewController(labs: rootLabs, navBarTitle: "Swift Arcade Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.rootViewController = navigatorController

            return true
    }

}
