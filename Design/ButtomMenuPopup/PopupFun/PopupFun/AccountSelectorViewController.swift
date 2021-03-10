//
//  AccountSelectorViewController.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import UIKit

class AccountSelectorViewController: UIViewController {
        
    let backgroundOverlayView = UIView()
    let stackView = UIStackView()
    let headerView = AccountSelectorHeaderView()
    let topSpacerHeight: CGFloat
    
    init(height: CGFloat) {
        self.topSpacerHeight = height
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setup()
        layout()
    }
}

extension AccountSelectorViewController {
    func style() {
        backgroundOverlayView.translatesAutoresizingMaskIntoConstraints = false
        backgroundOverlayView.backgroundColor = .black
        backgroundOverlayView.alpha = 0.3
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setup() {
        
    }
    
    func layout() {
        stackView.addArrangedSubview(headerView)
        
        view.addSubview(backgroundOverlayView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpacerHeight),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
