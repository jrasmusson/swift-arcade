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

            let rootLabs = [
                Lab(name: "UIKit", viewController: makeUIKitArcade()),
                Lab(name: "Navigation", viewController: makeNavigationArcade()),
                Lab(name: "Communication", viewController: makeCommunicationArcade()),
                Lab(name: "CoreData", viewController: makeCoreDataArcade()),
            ]

            let rootViewController = DemoViewController(labs: rootLabs, navBarTitle: "Cocoa Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.backgroundColor = .white
            window?.rootViewController = navigatorController

            return true
    }

}

extension AppDelegate {
    
    func makeUIKitArcade() -> UIViewController {
        
        // UITableView
        let uitableViewPatterns = [
            Lab(name: "Edit Mode", viewController: SimpleListEditModeViewController()),
            Lab(name: "Swipable Actions", viewController: SwipingActionsTableViewController()),
            Lab(name: "Modal", viewController: SimpleListAddModalViewController()),
        ]

        let uitableViewController = DemoViewController(labs: uitableViewPatterns, navBarTitle: "UITableView")

        // UITableViewCell
        let uitableViewCellPatterns = [
            Lab(name: "Custom Cell", viewController: CustomCellViewController()),
        ]

        let uitableViewCellController = DemoViewController(labs: uitableViewCellPatterns, navBarTitle: "UITableViewCell")
        
        // NSAttributedString
        let nsAttributedStringPatterns = [
            Lab(name: "Paragraphs", viewController: NSAttributedStringParagraphs()),
            Lab(name: "BaselineOffset", viewController: NSAttributedStringBaselineOffset()),
        ]

        let  nsAttributedStringController = DemoViewController(labs: nsAttributedStringPatterns, navBarTitle: "NSAttributedString")

        let uikitLabs = [
            Lab(name: "UITableView", viewController: uitableViewController),
            Lab(name: "UITableViewCell", viewController: uitableViewCellController),
            Lab(name: "NSAttributedString", viewController: nsAttributedStringController)
        ]
        
        return DemoViewController(labs: uikitLabs, navBarTitle: "UIKIt")
    }
    
    func makeNavigationArcade() -> UIViewController {
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
        
        return DemoViewController(labs: navigationPatterns, navBarTitle: "Navigation")
    }
    
    func makeCommunicationArcade() -> UIViewController {
        let communicationPatterns = [
            Lab(name: "Protocol Delegate", viewController: ProtocolDelegateViewController()),
            Lab(name: "Closure", viewController: ClosureViewController()),
            Lab(name: "ResponderChain", viewController: ResponderChainViewController()),
            Lab(name: "Key-Value Observing", viewController: KVOViewController()),
            Lab(name: "Property Observers", viewController: PropertyObserverViewController()),
            Lab(name: "Notification Center", viewController: NotificationViewController()),
        ]
        return DemoViewController(labs: communicationPatterns, navBarTitle: "Communication")
    }
    
    func makeCoreDataArcade() -> UIViewController {
        let coreDataPatterns = [
            Lab(name: "Intro", viewController: CoreDataViewController()),
            Lab(name: "Fetched Results Demo", viewController: DemoFetchedResultsViewController()),
        ]

        return DemoViewController(labs: coreDataPatterns, navBarTitle: "CoreData")
    }
}
