//
//  DrawRectView.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import Foundation
import UIKit

class DrawRectView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.red.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(10) // border centered on edge
        context.addRect(rectangle)
        context.drawPath(using: .fillStroke)
        context.fill(rectangle)
    }
}
