//
//  CategoryView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-29.
//

import UIKit
import SwiftUI

class CategoryView: UIView {

    let stackView = UIStackView()
    let categories = [
        CategoryItemView(imageName: "dollarsign.circle", text: "Buy & Sell"),
        CategoryItemView(imageName: "car", text: "Autos"),
        CategoryItemView(imageName: "house", text: "Real Estate"),
        CategoryItemView(imageName: "briefcase", text: "Jobs"),
        CategoryItemView(imageName: "person.3.sequence", text: "Categories"),
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 100)
    }
}

extension CategoryView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .center

        categories.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func layout() {
        addSubview(stackView)

        categories.forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

@available(iOS 13.0, *)
struct CategorView_Preview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let view = CategoryView()
      return view
    }.previewLayout(.sizeThatFits)
     .padding(10)
  }
}
