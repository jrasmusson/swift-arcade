//
//  ViewController.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import UIKit

class ViewController: UIViewController {
    
    let accountView = AccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setup()
        layout()
    }
}

extension ViewController {
    
    func style() {
        accountView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup() {
        accountView.delegate = self
    }
    
    func layout() {
        view.addSubview(accountView)
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
            accountView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: accountView.trailingAnchor, multiplier: 3),
        ])
    }
}

extension ViewController: AccountViewDelegate {
    func didTap(_ sender: AccountView) {
        let height = UIScreen.main.bounds.height * 0.5
        let vc = AccountSelectorViewController(height: height)
        vc.modalPresentationStyle = .overCurrentContext
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
