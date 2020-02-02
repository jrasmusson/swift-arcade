//
//  TabViewController.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "TabBar Container"

        let firstViewController = TabBarViewController1()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = TabBarViewController2()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        viewControllers = [firstViewController, secondViewController]
    }
}

class TabBarViewController1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class TabBarViewController2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
    }
}
