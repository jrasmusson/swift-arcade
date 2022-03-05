//
//  ViewController.swift
//  StackViewAnimation
//
//  Created by jrasmusson on 2022-03-05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var extraLabel1: UILabel!
    @IBOutlet var extraLabel2: UILabel!
    @IBOutlet var extraLabel3: UILabel!
    @IBOutlet var extraLabel4: UILabel!
    @IBOutlet var extraLabel5: UILabel!

    @IBOutlet var showMoreLabel: UILabel!

    var showAll = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupTapGesture()
        setupHiddenElements()
    }

    private func setupTapGesture() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(showMoreTapped))
        showMoreLabel.addGestureRecognizer(singleTap)
    }

    private func setupHiddenElements() {
        _ = [extraLabel1, extraLabel2, extraLabel3, extraLabel4, extraLabel5].map { $0?.isHidden = true }
    }

    @objc func showMoreTapped() {
        showAll = !showAll
//        animateVisibility()
//        animateVisibilityAndAlpha()
        staggerAnimations()
    }
}

// MARK: Animations
extension ViewController {

    func animateVisibility() {
        let duration = 2.0
        let animatables = [extraLabel1, extraLabel2, extraLabel3, extraLabel4, extraLabel5]

        let animation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) { [self] in
            _ = animatables.map { $0?.isHidden = !showAll }
        }
        animation.startAnimation()
    }

    func animateVisibilityAndAlpha() {
        let duration = 2.0
        let animatables = [extraLabel1, extraLabel2, extraLabel3, extraLabel4, extraLabel5]
        if showAll {
            _ = animatables.map { $0?.alpha = 0}
        }

        let animation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) { [self] in
            _ = animatables.map { $0?.isHidden = !showAll }
            _ = animatables.map { $0?.alpha = 1}
        }
        animation.startAnimation()
    }

    func staggerAnimations() {
        let duration1 = 0.4
        let duration2 = 0.2

        // initially hide...
        let animatables = [extraLabel1, extraLabel2, extraLabel3, extraLabel4, extraLabel5]
        _ = animatables.map { $0?.alpha = 0 }

        // then animate visibility in...
        let firstAnimation = UIViewPropertyAnimator(duration: duration1, curve: .easeInOut) { [self] in
            _ = animatables.map { $0?.isHidden = !showAll }
        }

        firstAnimation.addCompletion { position in
            if position == .end {
                // followed by alpha
                let secondAnimation = UIViewPropertyAnimator(duration: duration2, curve: .easeInOut) {
                    _ = animatables.map { $0?.alpha = 1 }
                }
                secondAnimation.startAnimation()
            }
        }
        firstAnimation.startAnimation()
    }
}
