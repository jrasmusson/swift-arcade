//
//  ViewController.swift
//  HTTP
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-23.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    func style() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of transactions"
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Fetch", for: .normal)
        button.addTarget(self, action: #selector(fetchButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 2),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor)
        ])
    }
    
    @objc func fetchButtonTapped() {
        HistoryService.shared.fetchTransactions { (result) in
            switch result {
            case .success(let transactions):
                print(transactions.count)
                self.label.text = String(transactions.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

