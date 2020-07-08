//
//  TileView.swift
//  Tiles
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-25.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    let label = UILabel()
    
    init(text: String) {
        super.init(frame: .zero)
        label.text = text
        backgroundColor = .systemYellow
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 300)
    }
}
