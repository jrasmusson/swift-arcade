//
//  HomeCell.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-06-05.
//

import UIKit

class HomeItemCell: UICollectionViewCell {
    let imageView = UIView()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let favoriteImageView = UIImageView()

    static let reuseIdentifier = "home-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: HomeViewController.height)
    }
}

// MARK: - Layout Style
extension HomeItemCell {
    func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = appColor

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

    }

    func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)

        let inset = 4.0

        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])

        // imageView
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}

// MARK: - Configure
extension HomeItemCell {
    func configure(item: HomeItem) {
        descriptionLabel.text = item.description
    }
}
