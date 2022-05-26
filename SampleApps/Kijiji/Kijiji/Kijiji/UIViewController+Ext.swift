//
//  UIViewController+Ext.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-26.
//

import UIKit

extension UIViewController {
    func setTabBarimage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
