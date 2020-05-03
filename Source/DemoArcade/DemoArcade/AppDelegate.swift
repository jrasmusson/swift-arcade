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
                Lab(name: "Navigation", viewController: makeNavigationDemos()),
                Lab(name: "Communication", viewController: makeCommunicationDemos()),
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

// Mark: - UIKit

extension AppDelegate {
    
    func makeUIKitDemos() -> UIViewController {
        
        // UITableView
        
        // Simple TableView
        let simpleTableViewDemos = [
            Lab(name: "Extending UITableViewController", viewController: ExtendingUITableViewController()),
            Lab(name: "Using UITableViewController", viewController: UsingUITableViewController()),
        ]

        let simpleTableViewDemoViewController = DemoViewController(labs: simpleTableViewDemos, navBarTitle: "Simple TableViews")

        // Edit Modes
        let editModeDemos = [
            Lab(name: "Basic", viewController: BasicEditModeViewController()),
            Lab(name: "Swipable Actions", viewController: SwipingActionsTableViewController()),
            Lab(name: "Modal", viewController: SimpleListAddModalViewController()),
        ]

        let editModeViewController = DemoViewController(labs: editModeDemos, navBarTitle: "Edit Modes")

        // All TableView Demos
        let allTableViewDemos = [
            Lab(name: "Simple TableViews", viewController: simpleTableViewDemoViewController),
            Lab(name: "Edit Modes", viewController: editModeViewController),
        ]

        let allTableViewDemoViewController = DemoViewController(labs: allTableViewDemos, navBarTitle: "UITableView")


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
            Lab(name: "UIScrollView", viewController: makeScrollViewDemos()),
            Lab(name: "UITableView", viewController: allTableViewDemoViewController),
            Lab(name: "UITableViewCell", viewController: uitableViewCellController),
            Lab(name: "NSAttributedString", viewController: nsAttributedStringController),
            Lab(name: "Diffable Data Sources", viewController: diffableViewController),
            Lab(name: "Moveable Cells", viewController: moveableCellsViewController),
            Lab(name: "UIPanGestureRecognizer", viewController: panGestureViewController),

        ]
        
        return DemoViewController(labs: uikitLabs, navBarTitle: "UIKIt")
    }
    
    func makeScrollViewDemos() -> UIViewController {
        
        // Understanding
        let understandingScrollViews = [
            Lab(name: "How it works", viewController: HowUIScrollViewWorks()),
            Lab(name: "DIY ScrollView", viewController: DIYScrollView()),
            Lab(name: "The Real Thing", viewController: ExampleUIScrollView()),
        ]

        let understandingScrollViewController = DemoViewController(labs: understandingScrollViews, navBarTitle: "Understanding the ScrollView")

        // Scrollable TabView
        let otherScrollViewDemoss = [
            Lab(name: "ScrollableTabView", viewController: ScrollableTabBarViewController()),
        ]

        let otherScrollDemoViewController = DemoViewController(labs: otherScrollViewDemoss, navBarTitle: "Other ScrollView Demos")

        // Combined
        let allScrollViewDemos = [
            Lab(name: "Understanding the ScrollView", viewController: understandingScrollViewController),
            Lab(name: "Other ScrollView Demos", viewController: otherScrollDemoViewController),
        ]
        
        return DemoViewController(labs: allScrollViewDemos, navBarTitle: "UIScrollView")
    }
}

// Mark: - Others

extension AppDelegate {
    
    func makeNavigationDemos() -> UIViewController {
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
