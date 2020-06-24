//
//  ViewController.swift
//  SpotifyAlbum
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-19.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let songs = ["Overture",
                 "The Grid",
                 "The Son of Flynn",
                 "Recognizer",
                 "Armory",
                 "Arena",
                 "Rinzler",
                 "The Game Has Changed",
                 "Outlands",
                 "Adagio for TRON",
                 "Nocturne",
                 "End of Line",
                 "Derezzed",
                 "Fall",
                 "Solar Sailer",
                 "Rectifier",
                 "Disc Wars",
                 "C.L.U.",
                 "Arrival",
                 "Flynn Lives",
                 "TRON Legacy (End Titles)",
                 "Finale",
    ]
    
    static let headerKind = "header-element-kind"

    var collectionView: UICollectionView! = nil
    
    var headerView: HeaderView?
    var floatingHeaderView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

}

// MARK: Layout
extension ViewController {
    
    func layout() {
        // Collection View
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: ViewController.headerKind,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Floating header view
        floatingHeaderView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(floatingHeaderView)

        floatingHeaderView.track = Track(imageName: "tron")

        NSLayoutConstraint.activate([
            floatingHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            floatingHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }
    
    func createLayout() -> UICollectionViewLayout {

        // ListCell layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        // Header layout
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(300))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: ViewController.headerKind, alignment: .top)

        section.boundarySupplementaryItems = [sectionHeader]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    // ListCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCell.reuseIdentifier,
            for: indexPath) as! ListCell
        
        cell.label.text = songs[indexPath.item]
        
        return cell
    }
    
    // HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath) as! HeaderView

        let track = Track(imageName: "tron")
        headerView.track = track
        
        self.headerView = headerView
        self.headerView?.isHidden = true

        return headerView
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView)
        
    }
}
