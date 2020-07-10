//
//  Factories.swift
//  Starbucks
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-08.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}

extension UIColor {
    static let starYellow = UIColor(red: 204/255, green: 153/255, blue: 51/255, alpha: 1)
    static let tileBrown = UIColor(red: 235/255, green: 235/255, blue: 228/255, alpha: 1)
    static let darkGreen = UIColor(red: 0/255, green: 133/255, blue: 67/255, alpha: 1)
    static let lightGreen = UIColor(red: 0/255, green: 171/255, blue: 90/255, alpha: 1)
    static let backgroundWhite = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
}

