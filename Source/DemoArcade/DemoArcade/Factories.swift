//
//  Factories.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-02-02.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

func makeSymbolButton(systemName: String, target: Any, selector: Selector) -> UIButton {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)

    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(target, action: selector, for: .primaryActionTriggered)
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit

    return button
}

func makeSymbolImage(systemName: String) -> UIImage? {
    let configuration = UIImage.SymbolConfiguration(scale: .large)
    let image = UIImage(systemName: systemName, withConfiguration: configuration)

    return image
}

func makeSpotifyButton(withText title: String) -> UIButton {
    let button = UIButton()
    let buttonHeight: CGFloat = 40
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.minimumScaleFactor = 0.5
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = .spotifyGreen
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = buttonHeight / 2
    button.contentEdgeInsets = UIEdgeInsets(top: 10, left: buttonHeight, bottom: 10, right: buttonHeight)

    let attributedText = NSMutableAttributedString(string: title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.kern: 1
        ])

    button.setAttributedTitle(attributedText, for: .normal)

    return button
}

func makeLabel() -> UILabel {
    return makeLabel(withTitle: "")
}

func makeLabel(withTitle title: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = title
    label.textAlignment = .center
    label.textColor = .black
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true

    return label
}

func makeHorizontalStackView() -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.spacing = 8.0

    return stack
}

func makeVerticalStackView() -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8.0

    return stack
}

