//
//  ResponderChainViewController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

@objc // Responder Chain
protocol Respondable: AnyObject {
    func didPressCancel(_ sender: Any?)
}

extension ResponderChainViewController: Respondable {
    func didPressCancel(_ sender: Any?) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}

extension UIResponder {
    func responderChain() -> String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + " -> " + next.responderChain()
    }
}

class ResponderChainViewController: UIViewController {

    let startButton: UIButton = {
        let button = makeButton(withText: "Start")
        button.addTarget(self, action: #selector(startPressed), for: .primaryActionTriggered)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "Responder Chain"

        view.addSubview(startButton)

        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Actions

    @objc func startPressed() {
        if let navigationController = navigationController {
            let viewController = ResponderChainViewController1()
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
