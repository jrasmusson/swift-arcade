//
//  ChildView.swift
//  SubviewSpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

class ChildView: UIView {
    
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChildView {
    func style() {
        backgroundColor = .systemRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        button.setTitle("Make me blue", for: .normal)
    }
    
    func layout() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    @objc func buttonTapped() {
        backgroundColor = .systemBlue
    }
}
