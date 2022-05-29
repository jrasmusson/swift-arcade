//
//  UITextField+Ext.swift
//  Kijiji
//
//  Created by jrasmusson on 2022-05-28.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)
let searchToggleButton = UIButton(type: .custom)

extension UITextField {

    func enableSearchButton() {
        searchToggleButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        leftView = searchToggleButton
        leftViewMode = .always
    }

    func addSearchImage() {
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView)
        view.backgroundColor = .green
        leftViewMode = .always
        leftView = view
    }

    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }

    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}

