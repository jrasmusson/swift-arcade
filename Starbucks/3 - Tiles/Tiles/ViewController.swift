//
//  ViewController.swift
//  Tiles
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-25.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    let rootStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        rootStackView.axis = .vertical
        rootStackView.spacing = 8
        
        view.addSubview(scrollView)
        scrollView.addSubview(rootStackView)
        
        let tile1 = TileView(text: "Tile1")
        let tile2 = TileView(text: "Tile2")
        let tile3 = TileView(text: "Tile3")
        let tile4 = TileView(text: "Tile4")
        
        rootStackView.addArrangedSubview(tile1)
        rootStackView.addArrangedSubview(tile2)
        rootStackView.addArrangedSubview(tile3)
        rootStackView.addArrangedSubview(tile4)
                
        NSLayoutConstraint.activate([
            // pin scroll view to edges
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // pin stack view to inside of scroll view
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // make scroll view and stack the same
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }

}
