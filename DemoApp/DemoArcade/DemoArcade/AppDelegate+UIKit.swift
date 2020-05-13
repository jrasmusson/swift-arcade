//
//  AppDelegate+UIKit.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

// Mark: - UIKit

extension AppDelegate {
    
    func makeUIKitDemos() -> UIViewController {

        let uikitLabs = [
            Lab(name: "UINavigationController", viewController: makeNavigationDemos()),
            Lab(name: "UIPanGestureRecognizer", viewController: makePanGestureDemos()),
            Lab(name: "UIScrollView", viewController: makeScrollViewDemos()),
            Lab(name: "UITableView", viewController: makeTableViewDemos()),
            Lab(name: "UIViewController", viewController: makeViewControllerDemos()),
        ]
        
        return DemoViewController(labs: uikitLabs, navBarTitle: "UIKIt")
    }
    
    ///
    /// Factories
    ///
    
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
    
    func makePanGestureDemos() -> UIViewController {
        let panGestures = [
            Lab(name: "Moving Box", viewController: MovingBlock()),
        ]

        return DemoViewController(labs: panGestures, navBarTitle: "UIPanGestureRecognizer")
    }

    func makeTableViewDemos() -> UIViewController {
        // Simple TableView
        let simpleTableViewDemos = [
            Lab(name: "Extending UITableViewController", viewController: ExtendingUITableViewController()),
            Lab(name: "Using UITableViewController", viewController: UsingUITableViewController()),
        ]

        let simpleTableViewDemoViewController = DemoViewController(labs: simpleTableViewDemos, navBarTitle: "Simple TableViews")

        // Edit Modes
        let editModeDemos = [
            Lab(name: "Basic", viewController: BasicEditModeViewController()),
            Lab(name: "Swipable", viewController: SwipingActionsTableViewController()),
            Lab(name: "Modal", viewController: SimpleListAddModalViewController()),
        ]

        let editModeViewController = DemoViewController(labs: editModeDemos, navBarTitle: "Edit Modes")

        // Moveable Cells
        let moveableCells = [
            Lab(name: "Edit Mode", viewController: EditMode()),
            Lab(name: "Long Press", viewController: LongPress()),
        ]

        let moveableCellsViewController = DemoViewController(labs: moveableCells, navBarTitle: "Moveable Cells")

        // Diffable Data Source
        let diffableDataSources = [
            Lab(name: "WIFI Settings UITableView", viewController: WIFISettingsViewController()),
            Lab(name: "Mountain TableView", viewController: MountainTableViewController()),
            Lab(name: "Mountain CollectionView", viewController: MountainCollectionViewController()),
        ]

        let diffableViewController = DemoViewController(labs: diffableDataSources, navBarTitle: "Diffable Data Sources")

        // UITableViewCell
        let uitableViewCellPatterns = [
            Lab(name: "Custom Cell", viewController: CustomCellViewController()),
        ]

        let uitableViewCellController = DemoViewController(labs: uitableViewCellPatterns, navBarTitle: "UITableViewCell")

        // All TableView Demos
        let allTableViewDemos = [
            Lab(name: "Simple TableViews", viewController: simpleTableViewDemoViewController),
            Lab(name: "Edit Modes", viewController: editModeViewController),
            Lab(name: "Moveable Cells", viewController: moveableCellsViewController),
            Lab(name: "Diffable Data Sources", viewController: diffableViewController),
            Lab(name: "UITableViewCells", viewController: uitableViewCellController),
        ]

        return DemoViewController(labs: allTableViewDemos, navBarTitle: "UITableView")
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

        // All ScrollView
        let allScrollViewDemos = [
            Lab(name: "Understanding the ScrollView", viewController: understandingScrollViewController),
            Lab(name: "Other ScrollView Demos", viewController: otherScrollDemoViewController),
        ]
        
        return DemoViewController(labs: allScrollViewDemos, navBarTitle: "UIScrollView")
    }

    func makeViewControllerDemos() -> UIViewController {
        
        // Strategies for dealing with large ViewControllers
        
        let largeViewControllerStrategies = [
            Lab(name: "MVP - Simple", viewController: MVPSimpleViewController()),
            Lab(name: "MVP - Complex", viewController: MVPComplexViewController()),
        ]

        let largeViewControllerStrategyViewController = DemoViewController(labs: largeViewControllerStrategies, navBarTitle: "Large ViewController Strategies")

        // All ScrollView
        let allDemos = [
            Lab(name: "Large ViewController Strategies", viewController: largeViewControllerStrategyViewController),
        ]
        
        return DemoViewController(labs: allDemos, navBarTitle: "Large ViewController Strategies")
    }

}
