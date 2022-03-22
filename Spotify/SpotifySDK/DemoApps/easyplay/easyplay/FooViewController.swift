//
//  FooViewController.swift
//  easyplay
//
//  Created by jrasmusson on 2022-03-22.
//

import UIKit

class Foo: UIViewController {

    let stackView = UIStackView()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension Foo {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("Next", for: [])
        button.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
    }

    @objc func nextTapped(sender: UIButton) {

    }

    func layout() {
        stackView.addArrangedSubview(button)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
