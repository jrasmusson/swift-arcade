//
//  ViewController1.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-02-10.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class TargetActionViewController: UIViewController {

    let weatherButton: UIButton = {
        let button = makeButton(withText: "Fetch Weather")

        //
        // Target-Acation is the communication pattern that links UIKit controls to application instructions.
        //

        button.addTarget(self, action: #selector(weatherPressed), for: .touchDown)

        // This line of code above fires the weatherPressed method button is tapped. Target-action is the mechanism
        // that makes that happen.

        // target - This viewController (self)
        // action - method to be called when event occurs
        // event - UIControl.Event that got fired (primaryActionTriggered)

        // #selector is a unique

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        navigationItem.title = "Target Action"

        view.addSubview(weatherButton)

        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
    }

    @objc func weatherPressed() {
        print("Weather Pressed")
    }

}

// https://developer.apple.com/documentation/uikit/uicontrol#1943645

