//
//  NotificationBadgeView.swift
//  BellAnimation1
//
//  Created by Rasmusson, Jonathan on 2021-05-25.
//

import Foundation
import UIKit

class BellView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    var duration: Double = 1 {
        didSet { shakeWith(duration: duration, angle: angle, yOffset: yOffset) }
    }

    var angle: CGFloat = .pi/8 {
        didSet { shakeWith(duration: duration, angle: angle, yOffset: yOffset) }
    }

    var yOffset: CGFloat = 0.5 {
        didSet { shakeWith(duration: duration, angle: angle, yOffset: yOffset) }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let bundle = Bundle(for: BellView.self)
        bundle.loadNibNamed(String(describing: BellView.self), owner: self, options: nil)
        addSubview(contentView)

        setup()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 128, height: 128)
    }
}

// MARK: - Setup
extension BellView {
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
}

// MARK: - Actions
extension BellView {
    @objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: duration, angle: angle, yOffset: yOffset)
    }

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        print("duration: \(duration) angle: \(angle) offset: \(yOffset)")
        
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

        print("anchorPoint: \(imageView.layer.anchorPoint)")

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
          animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5,
                               relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
          },
          completion: nil
        )
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
