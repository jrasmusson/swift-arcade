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
                Lab(name: "UIKit", viewController: makeUIKitDemos()),
                Lab(name: "Communication", viewController: makeCommunicationDemos()),
                Lab(name: "Foundation", viewController: makeFoundation()),
                Lab(name: "CoreData", viewController: makeCoreDataDemos()),
                Lab(name: "Design", viewController: makeDesignDemos()),
            ]

            let rootViewController = DemoViewController(labs: rootLabs, navBarTitle: "Cocoa Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.backgroundColor = .white
            window?.rootViewController = navigatorController

            return true
    }

}

// Mark: Foundation

extension AppDelegate {

    func makeFoundation() -> UIViewController {
        
        // NSAttributedString
        let nsAttributedStringPatterns = [
            Lab(name: "Paragraphs", viewController: NSAttributedStringParagraphs()),
            Lab(name: "Bolding", viewController: NSAttributedStringBolding()),
            Lab(name: "Images", viewController: NSAttributedStringImages()),
            Lab(name: "Buttons", viewController: NSAttributedStringButtons()),
            Lab(name: "BaselineOffset", viewController: NSAttributedStringBaselineOffset()),
        ]

        let nsAttributedStringController = DemoViewController(labs: nsAttributedStringPatterns, navBarTitle: "NSAttributedString")

        // All Foundation
        let allFoundation = [
            Lab(name: "NSAttributedString", viewController: nsAttributedStringController),
        ]
        
        return DemoViewController(labs: allFoundation, navBarTitle: "Foundation")
    }
}


// Mark: - Others

extension AppDelegate {
        
    func makeCommunicationDemos() -> UIViewController {
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
    
    func makeCoreDataDemos() -> UIViewController {
        let coreDataPatterns = [
            Lab(name: "Intro", viewController: CoreDataViewController()),
            Lab(name: "Fetched Results Demo", viewController: DemoFetchedResultsViewController()),
        ]

        return DemoViewController(labs: coreDataPatterns, navBarTitle: "CoreData")
    }
    
    func makeDesignDemos() -> UIViewController {
        let coreDataPatterns = [
            Lab(name: "Load & Retry Screens", viewController: LoadAndRetryDemo()),
            Lab(name: "Popup Menu", viewController: PopupMenu()),
        ]

        return DemoViewController(labs: coreDataPatterns, navBarTitle: "Design")
    }
    
}
