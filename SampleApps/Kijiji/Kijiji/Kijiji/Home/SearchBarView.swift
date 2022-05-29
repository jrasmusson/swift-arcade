//
//  SearchBarView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-28.
//

import Foundation
import UIKit

class SearchBarView: UIView {

    let stackView = UIStackView()
    let imageView = UIImageView()
    let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 40)
    }
}

extension SearchBarView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondarySystemFill.cgColor

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.backgroundColor = .systemBackground

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search for anything..."

        layer.cornerRadius = 5
        clipsToBounds = true
    }

    func layout() {
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textField)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
