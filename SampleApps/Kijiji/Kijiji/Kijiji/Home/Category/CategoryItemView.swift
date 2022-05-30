//
//  CategoryItemView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-29.
//

import UIKit
import SwiftUI

enum Constants {
    static let itemWidth: CGFloat = 200
    static let itemRatio: CGFloat = 0.6
    static let imageWidth: CGFloat = 200
    static let imageRatio: CGFloat = 0.6
    static let circleWidth: CGFloat = 180
}

class CategoryItemView: UIView {

    let stackView = UIStackView()
    let categortyImageView = CategoryImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.itemWidth, height: Constants.itemWidth)
    }
}

extension CategoryItemView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.backgroundColor = .orange

        categortyImageView.translatesAutoresizingMaskIntoConstraints = false

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        label.adjustsFontForContentSizeCategory = true
        label.textColor = appColor
        label.text = "Buy & Sell"
    }

    func layout() {
        stackView.addArrangedSubview(categortyImageView)
        stackView.addArrangedSubview(label)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            categortyImageView.widthAnchor.constraint(equalToConstant: Constants.itemWidth * Constants.itemRatio),
            categortyImageView.heightAnchor.constraint(equalToConstant: Constants.itemWidth * Constants.itemRatio)
        ])
    }
}

@available(iOS 13.0, *)
struct CategoryItemView_Preview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let view = CategoryItemView()
      return view
    }.previewLayout(.sizeThatFits)
     .padding(10)
  }
}
