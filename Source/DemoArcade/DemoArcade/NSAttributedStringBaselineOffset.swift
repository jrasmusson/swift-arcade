//
//  NSAttributedStringBaselineOffset.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

fileprivate extension String {

    func formatted() -> NSAttributedString {

        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let monthAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout)]
        let termAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]

        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let priceString = NSAttributedString(string: self, attributes: priceAttributes)
        let monthString = NSAttributedString(string: "/mo", attributes: monthAttributes)
        let termString = NSAttributedString(string: "1", attributes: termAttributes)

        rootString.append(priceString)
        rootString.append(monthString)
        rootString.append(termString)

        return rootString
    }

}

class NSAttributedStringBaselineOffset: UIViewController {

    let label: UILabel = {
        let label = makeLabel()
        label.attributedText = "20".formatted()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "BaselineOffset"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1).isActive = true
    }
    
}
