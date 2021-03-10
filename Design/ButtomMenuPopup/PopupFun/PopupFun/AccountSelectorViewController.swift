//
//  AccountSelectorViewController.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import UIKit

class AccountSelectorViewController: UIViewController {
        
    let backgroundOverlayView = UIView()
    let headerView = AccountSelectorHeaderView()
    let contentHeight: CGFloat
    
    init(height: CGFloat) {
        self.contentHeight = height
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
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setup() {
        
    }
    
    func layout() {
        view.addSubview(backgroundOverlayView)
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            backgroundOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: contentHeight),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
