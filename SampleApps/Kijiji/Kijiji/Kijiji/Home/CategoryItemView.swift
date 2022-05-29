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

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension CategoryItemView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemRed

        stackView.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.ima ge = UI
        // U R HERE

    }

    func layout() {

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
