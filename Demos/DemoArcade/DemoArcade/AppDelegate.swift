//
//  AppDelegate.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()

            let containerLabs = [
                Lab(name: "NavigationController", viewController: NavigationViewController1()),
                Lab(name: "TabViewController", viewController: TabBarViewController()),
                Lab(name: "PageViewController", viewController: PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)),
            ]

            let containerViewController = DemoViewController(labs: containerLabs, navBarTitle: "Container")

            let navigationLabs = [
                Lab(name: "Modal", viewController: ModalNavigation()),
                Lab(name: "Container", viewController: containerViewController),
                Lab(name: "Custom", viewController: ContainerViewController()),
            ]

            //
            // Top level
            //

            let navigationViewController = DemoViewController(labs: navigationLabs, navBarTitle: "Navigation")

            let rootLabs = [
                Lab(name: "Navigation", viewController: navigationViewController),
            ]

            let rootViewController = DemoViewController(labs: rootLabs, navBarTitle: "UIKit Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.rootViewController = navigatorController

            return true
    }

}

