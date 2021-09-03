//
//  ViewController.swift
//  RadioFun
//
//  Created by jrasmusson on 2021-02-01.
//

import UIKit

class ViewController: UIViewController {

    let creditCard = CreditCardControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        creditCard.translatesAutoresizingMaskIntoConstraints = false
        creditCard.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(creditCard)
        
        NSLayoutConstraint.activate([
            creditCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creditCard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        creditCard.isOn = !creditCard.isOn
        creditCard.title.text = "XXXX-XXXX-XXXX-XXXX"
    }
}

