//
//  NSAttributedStringViewController.swift
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

class NSAttributedStringViewController: UIViewController {

    let offerLabel: UILabel = {
        let label = makeLabel()
        label.attributedText = "20".formatted()
        
        return label
    }()
    
    lazy var paragraphLabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeParagraphText()
        
        return label
    }()

    func makeParagraphText() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 24
        paragraphStyle.headIndent = 8
        paragraphStyle.tailIndent = -8
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .justified
        paragraphStyle.paragraphSpacingBefore = 4
        paragraphStyle.paragraphSpacing = 24 // end of paragraph

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let rootString = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n", attributes: attributes)

        let secondParagraph = NSAttributedString(string: "Vulputate enim nulla aliquet porttitor lacus. Ipsum suspendisse ultrices gravida dictum fusce ut placerat. In fermentum et sollicitudin ac orci phasellus egestas tellus. Eu facilisis sed odio morbi quis commodo odio. Neque aliquam vestibulum morbi blandit cursus risus.", attributes: attributes)
        
        rootString.append(secondParagraph)
        
        return rootString
    }
    
    lazy var boldLabel: UILabel = {
        let label = makeLabel()
        label.attributedText = makeBoldText()
        return label
    }()
    
    func makeBoldText() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.black
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 14)

        let text = NSMutableAttributedString(string: "Please", attributes: plainTextAttributes)
        text.append(NSAttributedString(string: " stay on this screen ", attributes: boldTextAttributes))
        text.append(NSAttributedString(string: "while we activate your service. This process may take a few minutes.", attributes: plainTextAttributes))

        return text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "NSAttributedString"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(offerLabel)
        stackView.addArrangedSubview(paragraphLabel)
        stackView.addArrangedSubview(boldLabel)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1).isActive = true
    }
    
}


