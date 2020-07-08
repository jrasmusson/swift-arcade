//
//  HomeHeaderView.swift
//  StarBucks
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let greeting = UILabel()
    let inboxButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    
    func style() {
        backgroundColor = .white
        
        greeting.translatesAutoresizingMaskIntoConstraints = false
        greeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greeting.text = "Good afternoon,  Jonathan ☀️"
        greeting.numberOfLines = 0
        greeting.lineBreakMode = .byWordWrapping

        makeInboxButton()
    }
    
    func layout() {
        addSubview(greeting)
        addSubview(inboxButton)
        
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            greeting.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: greeting.trailingAnchor, multiplier: 2),
            
            inboxButton.topAnchor.constraint(equalToSystemSpacingBelow: greeting.bottomAnchor, multiplier: 2),
            inboxButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            inboxButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            bottomAnchor.constraint(equalToSystemSpacingBelow: inboxButton.bottomAnchor, multiplier: 1)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: Factories
extension HeaderView {
    func makeInboxButton() {
        inboxButton.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "envelope", withConfiguration: configuration)

        inboxButton.setImage(image, for: .normal)
        inboxButton.imageView?.tintColor = .secondaryLabel
        inboxButton.imageView?.contentMode = .scaleAspectFit

        inboxButton.setTitle("Inbox", for: .normal)
        inboxButton.setTitleColor(.secondaryLabel, for: .normal)
        
        inboxButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        inboxButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
