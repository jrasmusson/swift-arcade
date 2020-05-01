//
//  DIYScrollView.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-01.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
 
 This example shows how we can make our own `UIScrollView`.
 
 By creating our own view (CustomScrollView), and adding a `UIPanGestureRecognizer`
 we can detect the distance a user swipes, and translate that into a scroll by
 updating the views bounds.
 
 Blog post: https://github.com/jrasmusson/swift-arcade/blob/master/UIKIt/UIScrollView/README.md
 
 */
import UIKit

class DIYScrollView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        let customScrollView = CustomScrollView(frame: view.bounds)
        customScrollView.contentSize = CGSize(width: view.bounds.size.width, height: 1000)

        let redView = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        let greenView = UIView(frame: CGRect(x: 150, y: 160, width: 150, height: 200))
        let blueView = UIView(frame: CGRect(x: 40, y: 400, width: 200, height: 150))
        let yellowView = UIView(frame: CGRect(x: 100, y: 600, width: 180, height: 150))

        redView.backgroundColor = .systemRed
        greenView.backgroundColor = .systemGreen
        blueView.backgroundColor = .systemBlue
        yellowView.backgroundColor = .systemYellow

        customScrollView.addSubview(redView)
        customScrollView.addSubview(greenView)
        customScrollView.addSubview(blueView)
        customScrollView.addSubview(yellowView)

        view = customScrollView
    }
}

///
/// By creating a customer view with a `UIPanGestureRecognizer` we can create our own poormans `UIScrollView`.
///
///
///
class CustomScrollView: UIView {

    var contentSize = CGSize(width: 300, height: 800)

    lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
        return recognizer
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addGestureRecognizer(panRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        switch recognizer.state {
        case .changed:

            var bounds = self.bounds

            // max amount we can scroll in the Y-axis
            let maxOffsetY = contentSize.height - bounds.size.height
            
            // offset due to gesture
            let offsetY = bounds.origin.y - translation.y
            
            // don't allow scrolling in negative direction
            let minOffsetY = 0.0
            
            // let the newOffset be the smaller of the manual gesture or the max
            // but make it 0.0 if offest is negative
            let newOffsetY = fmax(CGFloat(minOffsetY), fmin(offsetY, maxOffsetY))
            
            // scroll by adjusting the bounds
            bounds.origin.y = newOffsetY
            self.bounds = bounds
            
            // reset recognizer
            recognizer.setTranslation(CGPoint.zero, in: self)
        default:
            ()
        }
    }
}
