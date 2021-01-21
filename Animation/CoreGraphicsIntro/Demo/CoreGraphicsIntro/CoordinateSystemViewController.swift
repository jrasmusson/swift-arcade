//
//  CoordinateSystemViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

/*
 In this example we abandon Auto Layout and hard code the positions of our
 views using `CGRect`.
 
 Note the coordinate system and how the middle of the screen is determined
 for the circle. We need to adjust it back by half it's width and height.
 */

// Note: Dimensions are hardcode for iPhone 11 Pro Max
//       bounds = 414 x 896

class CoordinateSystemViewController: UIViewController {

    // this absolutely positions a square in the middle of the screen.
    // note how the square is placed according to it's upper-left-hand coordinate
    let rectangleView = UIView(frame: CGRect(x: 414/2, y: 896/2, width: 200, height: 100))
    
    let circleView = UIImageView(frame: CGRect(x: 414/2-300/2, y: 896/2-300/2, width: 300, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleView.backgroundColor = .systemRed
        
        view.addSubview(circleView)
        view.addSubview(rectangleView)
        
        drawCircle()
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300).insetBy(dx: 5, dy: 5) // line width 10

            ctx.cgContext.setStrokeColor(UIColor.systemGreen.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        circleView.image = img
    }
}
