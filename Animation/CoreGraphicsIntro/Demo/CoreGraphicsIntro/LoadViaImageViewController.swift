//
//  BasicShapesViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

// https://www.hackingwithswift.com/read/27/4/ellipses-and-checkerboards

class LoadViaImageViewController: UIViewController {

    // 1. Define container.
    let imageView = UIImageView()
    let button = makeButton(withText: "Redraw")
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        drawRectangle()
    }
}

extension LoadViaImageViewController {
    
    func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        currentDrawType += 1
        
        if currentDrawType > 1 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        default:
            break
        }
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

// MARK: - Shapes

extension LoadViaImageViewController {
    
    // Because `setLineWidth` straddles the path, we need to inset the rectangle by
    // half the line width if we want the image to be fully visible in the rect area.
    //
    // .insetBy(dx: 5, dy: 5)
    //
    // For a line width of 10
    //
    // ctx.cgContext.setLineWidth(10)
    //
    func drawRectangle() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = render.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

        // 2. Create graphic.
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        // 3. Load into imageView container.
        imageView.image = img
    }
}
