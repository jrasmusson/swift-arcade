//
//  CategoryImageView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-30.
//

import UIKit
import SwiftUI

class CategoryImageView: UIView {

    let contentView = UIView()
    let imageView = UIImageView()
    let circleView = CategoryCircle()

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.imageWidth, height: Constants.imageWidth)
    }
}

extension CategoryImageView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground

        contentView.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addImageWith(systemName: "dollarsign.circle", tintColor: appColor)

        circleView.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout() {
        contentView.addSubview(circleView)
        contentView.addSubview(imageView)

        addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth * Constants.imageRatio),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageWidth * Constants.imageRatio)
        ])

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),
            circleView.heightAnchor.constraint(equalToConstant: Constants.imageWidth),
        ])
    }
}

@available(iOS 13.0, *)
struct CategoryImageView_Preview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let view = CategoryImageView()
      return view
    }.previewLayout(.sizeThatFits)
     .padding(10)
  }
}

