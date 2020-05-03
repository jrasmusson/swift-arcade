//
//  ScrollableTabBar.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ScrollableTabBarViewController: UIViewController {

    let scrollableTabView: ScrollableTabView = {
        let view = ScrollableTabView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true

        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    var selectedCategory: Category = .games

    var offersForSelectedCategory: [Offer] {
        return offers.filter { $0.category == selectedCategory }.sorted { $0.name < $1.name }
    }

    var tabTiles: [TabView] {
        Category.allCases.map {
            let tabView = TabView(
                activeFont: UIFont.preferredFont(forTextStyle: .headline),
                inactiveFont: UIFont.preferredFont(forTextStyle: .headline),
                activeColor: .black,
                inactiveColor: .systemGray)
            tabView.label.text = $0.description
            return tabView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        loadData()
    }

    func setup() {
        scrollableTabView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }

    func layout() {
        view.addSubview(scrollableTabView)
        view.addSubview(tableView)

        scrollableTabView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        scrollableTabView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollableTabView.trailingAnchor, multiplier: 0).isActive = true

        tableView.topAnchor.constraint(equalToSystemSpacingBelow: scrollableTabView.bottomAnchor, multiplier: 0).isActive = true
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 0).isActive = true
        tableView.tableFooterView = UIView() // hide empty rows

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }

    func loadData() {
        scrollableTabView.setup(tabs: tabTiles, selectedIndex: 0)
        tableView.reloadData()
    }
}

extension ScrollableTabBarViewController: ScrollableTabViewDelegate {
    
    ///
    /// When tab is tapped reload data.
    ///
    func scrollableTabView(_ tabView: ScrollableTabView, didTapTabAt index: Int) {

        guard index < Category.allCases.count else { return }
        selectedCategory = Category.allCases.filter { $0.rawValue == index }.first!

        tableView.reloadData()
    }
}

// MARK: - UITableView Delegate

extension ScrollableTabBarViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

// MARK: - UITableView DataSource

extension ScrollableTabBarViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = offersForSelectedCategory[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")

        cell.textLabel?.text = offer.name

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersForSelectedCategory.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


