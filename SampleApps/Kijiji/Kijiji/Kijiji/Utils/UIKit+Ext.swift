//
//  ViewController+Ext.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-27.
//

import UIKit

let appColor: UIColor = .systemIndigo

extension UIViewController {
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    func setTabBarItem(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}

extension UIImageView {
    func addImageWith(systemName: String, tintColor: UIColor) {
        let image = UIImage(systemName: systemName)!.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        self.image = image
    }
}
