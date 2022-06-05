//
//  HomeCell.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-06-05.
//

import UIKit

class HomeCell: UICollectionViewCell {
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
        return CGSize(width: UIView.noIntrinsicMetric, height: 160)
    }
}

// MARK: - Layout Style
extension HomeCell {
    func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = appColor

    }

    func layout() {
        contentView.addSubview(imageView)

        let inset = 4.0

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
