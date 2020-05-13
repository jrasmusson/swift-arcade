//
//  TabView.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

public class TabView: UIView {
    public let label = UILabel()

    let activeColor: UIColor
    let inactiveColor: UIColor

    let activeFont: UIFont
    let inactiveFont: UIFont

    var active: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.label.textColor = self.active ? self.activeColor : self.inactiveColor
                self.label.font = self.active ? self.activeFont : self.inactiveFont
            }
        }
    }

    public init(activeFont: UIFont,
                inactiveFont: UIFont,
                activeColor: UIColor,
                inactiveColor: UIColor) {

        self.activeColor = activeColor
        self.inactiveColor = inactiveColor

        self.activeFont = activeFont
        self.inactiveFont = inactiveFont

        super.init(frame: .zero)

        label.textColor = inactiveColor
        label.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: label.leadingAnchor),
            trailingAnchor.constraint(equalTo: label.trailingAnchor),

            topAnchor.constraint(equalTo: label.topAnchor),
            bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
