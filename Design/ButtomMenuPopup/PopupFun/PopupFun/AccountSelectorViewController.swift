//
//  AccountSelectorViewController.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import UIKit

class AccountSelectorViewController: UIViewController {
        
    let headerLabel = UILabel()
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
//        view.backgroundColor = .systemOrange
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "To Account"
    }

    func setup() {
        
    }
    
    func layout() {
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: contentHeight),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
        ])
    }
}
