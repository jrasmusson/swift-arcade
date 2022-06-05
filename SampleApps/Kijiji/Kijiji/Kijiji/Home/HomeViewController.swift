//
//  HomeViewController.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-26.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    enum Section {
        case main
    }

    let searchBarView = SearchBarView()
    let categoryView = CategoryView()
    var collectionView: UICollectionView! = nil

    var items: [HomeItem]?

    static let height = 200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchData()
    }

    // heights
    let searchBarHeight = 40.0
    let categoryHeight = 80.0

    // snap heights
    let categoryAdjustmentNoSnap = 40.0 + 8.0
    let categoryAdjustmentWithSnap = 0.0

    let collectionAdjustmentNoSnap = 40.0 + 8.0 + 80
    let collectionAdjustmentWithSnap = 40.0 + 8.0

    var categoryTopConstraint: NSLayoutConstraint?
    var collectionTopConstraint: NSLayoutConstraint?
}

// MARK: - Fetch Data
extension HomeViewController {
    func fetchData() {
        let homeItem = HomeItem(description: "Mens golf clubs", price: "$500")
        items = Array(repeating: homeItem, count: 20)
    }
}

// MARK: - Style and Layout
extension HomeViewController {

    func style() {
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.translatesAutoresizingMaskIntoConstraints = false

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .tertiarySystemFill
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: HomeItemCell.reuseIdentifier)
    }

    func layout() {
        view.addSubview(searchBarView)
        view.addSubview(categoryView)
        view.addSubview(collectionView)

        // SearchBar
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            searchBarView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBarView.trailingAnchor, multiplier: 1)
        ])

        // CategoryView
        categoryTopConstraint = categoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                  constant: categoryAdjustmentNoSnap)

        NSLayoutConstraint.activate([
            categoryTopConstraint!,
            categoryView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: categoryView.trailingAnchor, multiplier: 1)
        ])

        // CollectionView
        collectionTopConstraint = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                      constant: collectionAdjustmentNoSnap)

        NSLayoutConstraint.activate([
            collectionTopConstraint!,
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    // Snap to position
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        let swipingUp = y > 0
        let shouldSnap = y > 20

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.categoryView.alpha = swipingUp ? 0.0 : 1.0

            self.categoryTopConstraint?.constant = shouldSnap ? self.categoryAdjustmentWithSnap : self.categoryAdjustmentNoSnap
            self.collectionTopConstraint?.constant = shouldSnap ? self.collectionAdjustmentWithSnap : self.collectionAdjustmentNoSnap
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - CollectionView
extension HomeViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(HomeViewController.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeItemCell.reuseIdentifier,
            for: indexPath) as? HomeItemCell else { fatalError("Could not create new cell") }

        let item = items?[indexPath.row] ?? HomeItem(description: "---", price: "---") // skeleton
        cell.configure(item: item)

        return cell
    }
}

struct HomeViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            HomeViewController()
        }
    }
}
