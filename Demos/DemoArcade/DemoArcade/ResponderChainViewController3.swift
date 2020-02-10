//
//  ResponderViewController3.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ResponderChainViewController3: UIViewController {

    let cancelButton: UIButton = {
        let button = makeButton(withText: "Cancel")

        // by setting target = nil, and specifiying action further up the chain,
        // we can target a specific responder further up the UIResponder chain
        button.addTarget(nil, action: #selector(Respondable.didPressCancel(_:)), for: .primaryActionTriggered)
//        UIApplication.shared.sendAction(#selector(Respondable.didPressCancel(_:)), to: nil, from: self, for: nil)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemRed
        navigationItem.title = "Responder3"

        view.addSubview(cancelButton)

        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        print("\n\n\n")
        print(view.responderChain())
    }
}
