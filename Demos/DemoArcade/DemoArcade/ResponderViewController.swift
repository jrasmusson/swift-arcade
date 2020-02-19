//
//  ResponderChainViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-19.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ResponderChainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Responder Chain"

        view.addSubview(responderButton)

        responderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        responderButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
    }

    let responderButton: UIButton = {
        let button = makeButton(withText: "Fire Responder")
        button.addTarget(self, action: #selector(responderPressed), for: .primaryActionTriggered)
        return button
    }()

    @objc func responderPressed() {

        UIApplication.shared.sendAction(
            #selector(ResponderAction.fetchWeather),
            to: nil, from: self, for: nil)

    }
}

@objc protocol ResponderAction: AnyObject {
    func fetchWeather(sender: Any?)
}
