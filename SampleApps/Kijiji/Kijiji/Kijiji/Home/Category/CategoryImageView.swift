//
//  CategoryImageView.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-30.
//

import UIKit
import SwiftUI

class CategoryCircle: UIView {

    let width: CGFloat = 200
    let scaleRatio: CGFloat = 0.6

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let rectangle1 = CGRect(x: 0, y: 0, width: width, height: width)

        context.setFillColor(UIColor.systemBackground.cgColor)
        context.addRect(rectangle1)
        context.drawPath(using: .fillStroke)
        context.fill(rectangle1)

        let rectangle2 = CGRect(x: 0, y: 0, width: width, height: width).insetBy(dx: 10, dy: 10)

        context.setFillColor(UIColor.systemGray4.cgColor)
        context.setStrokeColor(UIColor.systemGray4.cgColor)
        context.setLineWidth(10)
        context.addEllipse(in: rectangle2)
        context.drawPath(using: .fillStroke)
    }
}

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
        return CGSize(width: Constants.width, height: Constants.width)
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

            imageView.widthAnchor.constraint(equalToConstant: Constants.width * Constants.ratio),
            imageView.heightAnchor.constraint(equalToConstant: Constants.width * Constants.ratio)
        ])

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: Constants.width),
            circleView.heightAnchor.constraint(equalToConstant: Constants.width),
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

