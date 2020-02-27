//
//  TextFieldViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-27.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {

    let textField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = UIFont.preferredFont(forTextStyle: .body)
            textField.textAlignment = .center
            textField.backgroundColor = .systemFill

            return textField
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViews()
    }

    func setupDelegates() {
        textField.delegate = self
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(textField)

        textField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 3).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    // MARK: - Textfield

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // gives up keyboard on touch
    }
}


extension TextFieldViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Check textfield")
    }
}
