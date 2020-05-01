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
                Lab(name: "UIKit", viewController: makeUIKit()),
                Lab(name: "Navigation", viewController: makeNavigation()),
                Lab(name: "Communication", viewController: makeCommunication()),
                Lab(name: "CoreData", viewController: makeCoreData()),
                Lab(name: "Design", viewController: makeDesign()),
            ]

            let rootViewController = DemoViewController(labs: rootLabs, navBarTitle: "Cocoa Demos")
            let navigatorController = UINavigationController(rootViewController: rootViewController)

            window?.backgroundColor = .white
            window?.rootViewController = navigatorController

            return true
    }

}

extension AppDelegate {
    
    func makeUIKit() -> UIViewController {
        
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
            Lab(name: "Bolding", viewController: NSAttributedStringBolding()),
            Lab(name: "Images", viewController: NSAttributedStringImages()),
            Lab(name: "Buttons", viewController: NSAttributedStringButtons()),
            Lab(name: "BaselineOffset", viewController: NSAttributedStringBaselineOffset()),
        ]

        let nsAttributedStringController = DemoViewController(labs: nsAttributedStringPatterns, navBarTitle: "NSAttributedString")

        // Diffable Data Source
        let diffableDataSources = [
            Lab(name: "WIFI Settings UITableView", viewController: WIFISettingsViewController()),
            Lab(name: "Mountain TableView", viewController: MountainTableViewController()),
            Lab(name: "Mountain CollectionView", viewController: MountainCollectionViewController()),
        ]

        let diffableViewController = DemoViewController(labs: diffableDataSources, navBarTitle: "Diffable Data Sources")
        
        // UIScrollView
        let scrollViews = [
            Lab(name: "How it works", viewController: HowUIScrollViewWorks()),
            Lab(name: "DIY ScrollView", viewController: DIYScrollView()),
            Lab(name: "The Real Thing", viewController: ExampleUIScrollView()),
        ]

        let scrollViewController = DemoViewController(labs: scrollViews, navBarTitle: "UIScrollView")

        // Moveable Cells
        let moveableCells = [
            Lab(name: "Edit Mode", viewController: EditMode()),
            Lab(name: "Long Press", viewController: LongPress()),
        ]

        let moveableCellsViewController = DemoViewController(labs: moveableCells, navBarTitle: "Moveable Cells")
        
        // UIPanGestureRecognizer
        let panGestures = [
            Lab(name: "Moving Box", viewController: MovingBlock()),
        ]

        let panGestureViewController = DemoViewController(labs: panGestures, navBarTitle: "UIPanGestureRecognizer")

        let uikitLabs = [
            Lab(name: "UIScrollView", viewController: scrollViewController),
            Lab(name: "UITableView", viewController: uitableViewController),
            Lab(name: "UITableViewCell", viewController: uitableViewCellController),
            Lab(name: "NSAttributedString", viewController: nsAttributedStringController),
            Lab(name: "Diffable Data Sources", viewController: diffableViewController),
            Lab(name: "Moveable Cells", viewController: moveableCellsViewController),
            Lab(name: "UIPanGestureRecognizer", viewController: panGestureViewController),

        ]
        
        return DemoViewController(labs: uikitLabs, navBarTitle: "UIKIt")
    }
    
    func makeNavigation() -> UIViewController {
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
    
    func makeCommunication() -> UIViewController {
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
    
    func makeCoreData() -> UIViewController {
        let coreDataPatterns = [
            Lab(name: "Intro", viewController: CoreDataViewController()),
            Lab(name: "Fetched Results Demo", viewController: DemoFetchedResultsViewController()),
        ]

        return DemoViewController(labs: coreDataPatterns, navBarTitle: "CoreData")
    }
    
    func makeDesign() -> UIViewController {
        let coreDataPatterns = [
            Lab(name: "Load & Retry Screens", viewController: LoadAndRetryDemo()),
            Lab(name: "Popup Menu", viewController: PopupMenu()),
        ]

        return DemoViewController(labs: coreDataPatterns, navBarTitle: "Design")
    }
}
