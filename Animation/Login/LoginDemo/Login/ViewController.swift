//
//  ViewController.swift
//  Login
//
//  Created by jrasmusson on 2021-01-04.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    
    let formFieldView = FormFieldView()
    let undoButton = makeButton(withText: "Undo")
    
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
        stackView.alignment = .leading
        
        undoButton.addTarget(self, action: #selector(undoTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(formFieldView)
        stackView.addArrangedSubview(undoButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            formFieldView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: formFieldView.trailingAnchor, multiplier: 2),
            undoButton.heightAnchor.constraint(equalTo: formFieldView.heightAnchor),
            undoButton.widthAnchor.constraint(equalTo: formFieldView.widthAnchor),
        ])
    }
}

// MARK: - Actions
extension ViewController {
    
    @objc func undoTapped() {
        formFieldView.undo()
    }
    
}

// MARK: - Factories

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 60/4
    return button
}
