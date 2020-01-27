//
//  FailureViewController.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class FailureViewController: UIViewController {

    typealias responder = ContainerViewControllerResponder

    override func viewDidLoad() {
        view.backgroundColor = .red

        let titleLabel = makeLabel(withTitle: "Failure")
        let activateButton = makeButton(withText: "Try again")
        let cancelButton = makeButton(withText: "Cancel")

        // responder chain
        activateButton.addTarget(nil, action: #selector(responder.didPressPrimaryCTAButton(_:)), for: .primaryActionTriggered)
        cancelButton.addTarget(nil, action: #selector(responder.didPressSecondaryCTAButton(_:)), for: .primaryActionTriggered)

        view.addSubview(titleLabel)
        view.addSubview(activateButton)
        view.addSubview(cancelButton)

        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        cancelButton.topAnchor.constraint(equalTo: activateButton.bottomAnchor, constant: 8).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
