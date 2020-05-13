//
//  ScrollableTabView.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

public protocol ScrollableTabViewDelegate: AnyObject {
    func scrollableTabView(_ tabView: ScrollableTabView, didTapTabAt index: Int)
}

public class ScrollableTabView: UIView {

    let scrollView = UIScrollView()
    var tabs: [TabView] = []

    ///
    public let indicator = UIView()
    var indicatorLeading: NSLayoutConstraint?
    var indicatorTrailing: NSLayoutConstraint?
    ///
    
    public weak var delegate: ScrollableTabViewDelegate?

    public func setup(tabs: [TabView], selectedIndex: Int) {

        ///
        guard let firstTab = tabs.first else {
            return
        }

        let indicatorLeading = indicator.leadingAnchor.constraint(equalTo: firstTab.leadingAnchor)
        let indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: firstTab.trailingAnchor)

        self.indicatorLeading = indicatorLeading
        self.indicatorTrailing = indicatorTrailing
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .systemBlue
        ///

        for view in scrollView.subviews {
            view.removeFromSuperview()
        }

        self.tabs = tabs

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        addSubview(scrollView)
        scrollView.addSubview(indicator)

        for (index, tab) in tabs.enumerated() {
            scrollView.addSubview(tab)

            tab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabWasTapped(_:))))

            NSLayoutConstraint.activate([
                tab.topAnchor.constraint(equalTo: scrollView.topAnchor),
            ])

            let horizontalSpacing: CGFloat = 4.0

            if index == 0 {
                NSLayoutConstraint.activate([
                    tab.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: horizontalSpacing * 0.5)
                ])
            } else if index == tabs.count - 1 {
                NSLayoutConstraint.activate([
                    tab.leadingAnchor.constraint(equalToSystemSpacingAfter: tabs[index - 1].trailingAnchor, multiplier: horizontalSpacing),
                    scrollView.trailingAnchor.constraint(equalToSystemSpacingAfter: tab.trailingAnchor, multiplier: horizontalSpacing * 0.5)
                ])
            } else {
                NSLayoutConstraint.activate([
                    tab.leadingAnchor.constraint(equalToSystemSpacingAfter: tabs[index - 1].trailingAnchor, multiplier: horizontalSpacing)
                ])
            }
        }

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            topAnchor.constraint(equalTo: scrollView.topAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            ///
            indicator.topAnchor.constraint(equalToSystemSpacingBelow: firstTab.bottomAnchor, multiplier: 1.0),
            indicator.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            indicatorLeading,
            indicatorTrailing,
            indicator.heightAnchor.constraint(equalToConstant: 4),
            ///
        ])

        select(selectedIndex, animated: false)
    }

    @objc func tabWasTapped(_ recognizer: UIGestureRecognizer) {

        guard let tabView = recognizer.view as? TabView,
            let index = tabs.firstIndex(of: tabView) else {
                return
        }

        select(index)
    }

    public func select(_ tabIndex: Int, animated: Bool = true) {
        
        ///
        animateIndicator(to: tabIndex, animated: animated)
        ///
        
        for tab in tabs {
            tab.active = false
        }

        let selectedTab = tabs[tabIndex]
        selectedTab.active = true

        animateSelectedTabToCenter(selectedTab)

        delegate?.scrollableTabView(self, didTapTabAt: tabIndex)
    }

    /**
     This isn't quite an animate to center. We make a best effort, but if we are
     going to scroll the content view past its bounds we clamp it to either the
     leftmost bounds or rightmost bounds.

     This means tabs will hug either the left or right bounds, depending on
     which was selected.
     */
    private func animateSelectedTabToCenter(_ selectedTab: TabView) {

        // This is the offset of the scrollview needed to position the selected
        // tab at the center. It is potential, as we clamp the offset later if
        // the offset is too far.
        
        // potentialOffset - the amount would could potentially scroll from the middle
        // leftmostBounds  - the furthest to the left we could scroll (0 = no scrolling)
        // rightmostBounds - the furthest to the right we could ever scroll
        
        let potentialOffset = selectedTab.frame.midX - (scrollView.bounds.width * 0.5)
        let midX = selectedTab.frame.midX
        let actualOffset: CGFloat

        let leftmostBounds: CGFloat = 0
        let rightmostBounds = scrollView.contentSize.width - (scrollView.bounds.width)
        
        if potentialOffset < leftmostBounds {           // Left side
            actualOffset = leftmostBounds
            print("LEFT midX = \(midX) potentialOffset = \(potentialOffset) actualOffset = \(actualOffset)")
        } else if potentialOffset > rightmostBounds {   // Right side
            actualOffset = rightmostBounds
            print("RIGHT midX = \(midX) potentialOffset = \(potentialOffset) actualOffset = \(actualOffset)")
        } else {                                        // Middle area
            actualOffset = potentialOffset
            print("MIDDLE midX = \(midX) potentialOffset = \(potentialOffset) actualOffset = \(actualOffset)")
        }
        
        // animation handled here
        scrollView.setContentOffset(CGPoint(x: actualOffset, y: 0.0), animated: true)
    }

    ///
    private func animateIndicator(to index: Int, animated: Bool = true) {
        guard let indicatorLeading = indicatorLeading,
            let indicatorTrailing = indicatorTrailing else {
                return
        }

        let tabView = tabs[index]

        scrollView.removeConstraint(indicatorLeading)
        scrollView.removeConstraint(indicatorTrailing)

        self.indicatorLeading = indicator.leadingAnchor.constraint(equalTo: tabView.leadingAnchor, constant: -4)
        self.indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: tabView.trailingAnchor, constant: 4)

        self.indicatorLeading?.isActive = true
        self.indicatorTrailing?.isActive = true

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }

}


