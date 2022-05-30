//
//  CategoryCircle.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-30.
//

import UIKit
import SwiftUI

class CategoryCircle: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.circleWidth,
                      height: Constants.circleWidth)
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

//        let offset = Constants.circleWidth/Constants.itemWidth
//        let offset = Constants.itemWidth/Constants.circleWidth
//        let offset: CGFloat = 10
        let offset = (Constants.itemWidth - Constants.circleWidth)/2
        let rectangle1 = CGRect(x: offset,
                                y: offset,
                                width: Constants.circleWidth,
                                height: Constants.circleWidth)

        context.setFillColor(UIColor.systemBackground.cgColor)
        context.addRect(rectangle1)
        context.drawPath(using: .fillStroke)
        context.fill(rectangle1)

        let rectangle2 = CGRect(x: offset,
                                y: offset,
                                width: Constants.circleWidth,
                                height: Constants.circleWidth).insetBy(dx: 10, dy: 10)

        context.setFillColor(UIColor.systemGray4.cgColor)
        context.setStrokeColor(UIColor.systemGray4.cgColor)
        context.setLineWidth(10)
        context.addEllipse(in: rectangle2)
        context.drawPath(using: .fillStroke)
    }
}

@available(iOS 13.0, *)
struct CategoryCircleView_Preview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let view = CategoryCircle()
      return view
    }.previewLayout(.sizeThatFits)
     .padding(10)
  }
}
