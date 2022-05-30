//
//  CategoryView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-29.
//

import Foundation
import UIKit

class CategoryView: UIView {

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

extension CategoryView {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
    }

    func layout() {

    }
}
