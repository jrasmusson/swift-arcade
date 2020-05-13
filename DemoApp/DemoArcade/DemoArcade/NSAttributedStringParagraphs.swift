//
//  NSAttributedParagraphs.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class NSAttributedStringParagraphs: UIViewController {

    lazy var label: UILabel = {
        let label = makeLabel()
        label.attributedText = makeText()
        
        return label
    }()

    func makeText() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 24
        paragraphStyle.headIndent = 8
        paragraphStyle.tailIndent = -8
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .justified
        paragraphStyle.paragraphSpacingBefore = 4
        paragraphStyle.paragraphSpacing = 24 // end of paragraph

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let rootString = NSMutableAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n", attributes: attributes)

        let secondParagraph = NSAttributedString(string: "Vulputate enim nulla aliquet porttitor lacus. Ipsum suspendisse ultrices gravida dictum fusce ut placerat. In fermentum et sollicitudin ac orci phasellus egestas tellus. Eu facilisis sed odio morbi quis commodo odio.", attributes: attributes)
        
        rootString.append(secondParagraph)
        
        return rootString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Paragraphs"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1).isActive = true
    }
    
}
