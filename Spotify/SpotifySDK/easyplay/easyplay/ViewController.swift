//
//  ViewController.swift
//  easyplay
//
//  Created by jrasmusson on 2022-03-20.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appRemote = appDelegate.appRemote
        appRemote.authorizeAndPlayURI("https://open.spotify.com/track/4GM8o9HBjXtHQjAFOwDu5v?si=b2baddcca3d1461f")

        print("foo - accessToken: \(appDelegate.accessToken)")
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


