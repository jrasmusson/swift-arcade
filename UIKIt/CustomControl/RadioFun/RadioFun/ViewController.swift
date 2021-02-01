//
//  ViewController.swift
//  RadioFun
//
//  Created by jrasmusson on 2021-02-01.
//

import UIKit

class ViewController: UIViewController {

    let radioButton = CreditCardControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(radioButton)
        
        NSLayoutConstraint.activate([
            radioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        radioButton.isOn = !radioButton.isOn
        radioButton.title.text = "XXXX-XXXX-XXXX-XXXX"
    }
}

