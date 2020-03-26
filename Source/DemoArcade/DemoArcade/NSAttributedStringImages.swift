//
//  NSAttributedStringImages.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-26.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class NSAttributedStringImages: UIViewController {

    lazy var label: UILabel = {
        let label = makeLabel()
        label.attributedText = makeText()
        return label
    }()
    
    func makeText() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4

        var headerTextAttributes = [NSAttributedString.Key: AnyObject]()
        headerTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .body).withTraits(traits: [.traitBold])

        var subHeaderTextAttributes = [NSAttributedString.Key: AnyObject]()
        subHeaderTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        subHeaderTextAttributes[.foregroundColor] = UIColor.systemGray

        let rootString = NSMutableAttributedString(string: "Kevin Flynn", attributes: headerTextAttributes)
        rootString.append(NSAttributedString(string: "\nFebruary 10 • San Francisco ", attributes: subHeaderTextAttributes))

        rootString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, rootString.string.count))

        // image
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_icon")
        attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        rootString.append(NSAttributedString(attachment: attachment))
        
        return rootString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Bolding"
        
        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(label)
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1).isActive = true
    }
    
}
