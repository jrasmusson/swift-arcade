//
//  CategoryItemView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-29.
//

import UIKit
import SwiftUI

class CategoryItemView: UIView {

    let stackView = UIStackView()
    let imageView = UIImageView()

    let width: CGFloat = 200
    let imageRatio: CGFloat = 0.6

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: width)
    }
}

extension CategoryItemView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemRed

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addImageWith(systemName: "dollarsign.circle", tintColor: appColor)
    }

    func layout() {
        stackView.addArrangedSubview(imageView)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width * imageRatio),
            imageView.heightAnchor.constraint(equalToConstant: width * imageRatio)
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
