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

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.preferredFont(forTextStyle: .body)

        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(systemName: "heart")
        favoriteImageView.tintColor = appColor
    }

    func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favoriteImageView)

        let inset = 4.0

        // imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])

        // descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])

        // priceLabel
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])

        // favoriteImageView
        NSLayoutConstraint.activate([
            favoriteImageView.heightAnchor.constraint(equalToConstant: 20),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 20),
            favoriteImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset),
            favoriteImageView.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: inset),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            favoriteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}

// MARK: - Configure
extension HomeItemCell {
    func configure(item: HomeItem) {
        descriptionLabel.text = item.description
        priceLabel.text = item.price
    }
}
