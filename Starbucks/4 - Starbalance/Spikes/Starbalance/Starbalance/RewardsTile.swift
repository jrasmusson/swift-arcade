//
//  BalanceView.swift
//  Starbalance
//
//  Created by Jonathan Rasmusson Work Pro on 2020-06-25.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class RewardsTileView: UIView {
    
    let balanceView = BalanceView()
    var rewardsOptionButton = UIButton()
    let rewardsGraphView = RewardsGraphView()
    let starRewardsView = StarRewardsView()
    var detailsButton = UIButton()
    
    var heightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RewardsTileView {
    
    func style() {
        backgroundColor = .systemRed
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        makeRewardsOptionButton()

        detailsButton = makeClearButton(withText: "Details")
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .primaryActionTriggered)
    }
    
    func makeRewardsOptionButton() {
        rewardsOptionButton = UIButton()
        rewardsOptionButton.translatesAutoresizingMaskIntoConstraints = false
        rewardsOptionButton.addTarget(self, action: #selector(rewardOptionsTapped), for: .primaryActionTriggered)

        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)

        rewardsOptionButton.setImage(image, for: .normal)
        rewardsOptionButton.imageView?.tintColor = .label
        rewardsOptionButton.imageView?.contentMode = .scaleAspectFit

        rewardsOptionButton.setTitle("Rewards options", for: .normal)
        rewardsOptionButton.setTitleColor(.label, for: .normal)
        rewardsOptionButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)

        rewardsOptionButton.semanticContentAttribute = .forceRightToLeft
        rewardsOptionButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 0)
        rewardsOptionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    func layout() {
        addSubview(balanceView)
        addSubview(rewardsOptionButton)
        addSubview(rewardsGraphView)
        addSubview(starRewardsView)
        addSubview(detailsButton)
        
        heightConstraint = starRewardsView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: topAnchor),
            balanceView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            rewardsOptionButton.centerYAnchor.constraint(equalTo: balanceView.pointsLabel.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsOptionButton.trailingAnchor, multiplier: 3),
            
            rewardsGraphView.topAnchor.constraint(equalToSystemSpacingBelow: balanceView.bottomAnchor, multiplier: 1),
            rewardsGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 1),
            heightConstraint!,
            
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2),
        ])
        
        starRewardsView.isHidden = true
    }
    
    // Redraw our graph once we know our actual device width & height
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
}

// MARK: Actions
extension RewardsTileView {
    @objc func rewardOptionsTapped() {
        backgroundColor = .systemBlue
        if heightConstraint?.constant == 0 {
            self.setChevronUp()

            let animator1 = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 270
                self.layoutIfNeeded()
            }
            animator1.startAnimation()

            let animator2 = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.starRewardsView.isHidden = false
                self.starRewardsView.alpha = 1
            }
            animator2.startAnimation(afterDelay: 0.5)

        } else {
            self.setChevronDown()

            let animator1 = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 0
                self.starRewardsView.isHidden = true
                self.starRewardsView.alpha = 0
                self.layoutIfNeeded()
            }
            animator1.startAnimation()
        }
    }

    @objc func detailsButtonTapped() {
        print("Details tapped!!!")
    }

    private func setChevronUp() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        rewardsOptionButton.setImage(image, for: .normal)
    }

    private func setChevronDown() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        rewardsOptionButton.setImage(image, for: .normal)
    }
}
