//
//  HomeViewController.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-26.
//

import UIKit

class HomeViewController: UIViewController {

    let searchBarView = SearchBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController {
    func style() {
        view.backgroundColor = .secondarySystemFill
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout() {
//        view.addSubview(searchBarView)
//
//        NSLayoutConstraint.activate([
//            searchBarView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
//            searchBarView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBarView.trailingAnchor, multiplier: 1)
//        ])
    }
}
