//
//  DrawRectViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

class DrawRectViewController: UIViewController {
    
    // 1. Define a view.
    let drawRectView = DrawRectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        drawRectView.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(drawRectView)
        
        NSLayoutConstraint.activate([
            drawRectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drawRectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            drawRectView.widthAnchor.constraint(equalToConstant: 512),
            drawRectView.heightAnchor.constraint(equalToConstant: 512),
        ])
    }
}

class DrawRectView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 2. Override draw.
    override func draw(_ rect: CGRect) {
        
        let rectangle1 = CGRect(x: 0, y: 0, width: 200, height: 180).insetBy(dx: 10, dy: 10)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor(UIColor.systemRed.cgColor)
        context.setStrokeColor(UIColor.systemGreen.cgColor)
        context.setLineWidth(20)
        context.addRect(rectangle1)
        context.drawPath(using: .fillStroke)
        context.fill(rectangle1)
        
        // painters model
        
        let rectangle2 = CGRect(x: 256, y: 256, width: 128, height: 128)

        context.setFillColor(UIColor.systemYellow.cgColor)
        context.setStrokeColor(UIColor.systemBlue.cgColor)
        context.setLineWidth(10)

        context.addEllipse(in: rectangle2)
        context.drawPath(using: .fillStroke)
    }
}
