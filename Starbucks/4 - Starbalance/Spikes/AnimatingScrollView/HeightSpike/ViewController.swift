//
//  ViewController.swift
//  HeightSpike
//
//  Created by Jonathan Rasmusson Work Pro on 2020-07-01.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let redView = UIView()
    let blueView = UIView()
    let button = UIButton()
    
    var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    func style() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .systemRed
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setTitle("Toggle", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(toggleTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(redView)
        stackView.addArrangedSubview(blueView)
        stackView.addArrangedSubview(button)
                
        heightConstraint = redView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            redView.widthAnchor.constraint(equalToConstant: 200),
            heightConstraint!,
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            blueView.widthAnchor.constraint(equalToConstant: 200),
            blueView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc func toggleTapped() {
        if heightConstraint?.constant == 0 {
            UIView.animate(withDuration: 0.75) { [unowned self] in
                self.heightConstraint?.constant = 100
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.75) { [unowned self] in
                self.heightConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}
