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

            // UITableView Patterns
            let tableViewPatterns = [
                Lab(name: "Insert/Delete Swipes", viewController: InsertTableViewController()),
            ]

            // Navigation Patterns
            let containerPatterns = [
                Lab(name: "NavigationController", viewController: NavigationViewController1()),
                Lab(name: "TabViewController", viewController: TabBarViewController()),
                Lab(name: "PageViewController", viewController: PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)),
            ]

            let containerViewController = DemoViewController(labs: containerPatterns, navBarTitle: "Container")

            let navigationPatterns = [
                Lab(name: "Modal", viewController: ModalNavigation()),
                Lab(name: "Container", viewController: containerViewController),
                Lab(name: "Custom", viewController: ContainerViewController()),
            ]

            // Communication Patterns
            let communicationPatterns = [
                Lab(name: "Protocol Delegate", viewController: ProtocolDelegateViewController()),
                Lab(name: "Closure", viewController: ClosureViewController()),
                Lab(name: "ResponderChain", viewController: ResponderChainViewController()),
                Lab(name: "Key-Value Observing", viewController: KVOViewController()),
                Lab(name: "Property Observers", viewController: PropertyObserverViewController()),
                Lab(name: "Notification Center", viewController: NotificationViewController()),
            ]

            // CoreData
            let coreDataPatterns = [
                Lab(name: "Intro", viewController: CoreDataViewController()), // IntroViewController()
            ]

            //
            // Top level
            //

            let tableViewController = DemoViewController(labs: tableViewPatterns, navBarTitle: "UITableView")
            let navigationViewController = DemoViewController(labs: navigationPatterns, navBarTitle: "Navigation")
            let communicationViewController = DemoViewController(labs: communicationPatterns, navBarTitle: "Communication")
            let coreDataViewController = DemoViewController(labs: coreDataPatterns, navBarTitle: "CoreData")

            let rootLabs = [
                Lab(name: "UITableView", viewController: tableViewController),
                Lab(name: "Navigation", viewController: navigationViewController),
                Lab(name: "Communication", viewController: communicationViewController),
                Lab(name: "CoreData", viewController: coreDataViewController),
            ]

            let rootViewController = DemoViewController(labs: rootLabs, navBarTitle: "UIKit Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.backgroundColor = .white
            window?.rootViewController = navigatorController

            return true
    }

}
