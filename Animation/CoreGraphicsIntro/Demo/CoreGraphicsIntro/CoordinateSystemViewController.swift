//
//  CoordinateSystemViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

// Note: Dimensions are hardcode for iPad Pro (12.9-inch) (4th generation)
//       bounds = 1024 x 1366

class CoordinateSystemViewController: UIViewController {

    // this absolutely positions a square in the middle of the screen.
    // note how the square is placed according to it's upper-left-hand coordinate
    let redBoxInParentView = UIView(frame: CGRect(x: 1024/2, y: 1366/2, width: 200, height: 100))
    
    // or we can specify a view, and do our layout in there
    // to get the circle in the middle we had to take into account it's radious and shift it up and to the left
    let yellowCircleContainerView = UIImageView(frame: CGRect(x: 1024/2-300/2, y: 1366/2-300/2, width: 300, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redBoxInParentView.backgroundColor = .systemRed
        
        view.addSubview(yellowCircleContainerView)
        view.addSubview(redBoxInParentView)
        
        drawCircle()
    }
    
    //
    // This method gets an image renderer and uses it to create an image which we can then set in our
    // UIImageView container. Not how the coordinate system used here is relative to the renderer.
    //
    // Also because the line width = 10pts, and because lines are drawn on paths, half the circle will
    // appear outside and half will appear inside. For that reason we need to offset the circle 5pts
    // x and y to have full circle appear in layer.
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))

        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 300, height: 300).insetBy(dx: 5, dy: 5) // line width 10

            ctx.cgContext.setStrokeColor(UIColor.yellow.cgColor)
            ctx.cgContext.setLineWidth(10)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        yellowCircleContainerView.image = img
    }
}
