//
//  AccountSelectorHeaderView.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-10.
//

import Foundation
import UIKit

class AccountSelectorHeaderView: UIView {
    
    let headerLabel = UILabel()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 44)
    }
}

extension AccountSelectorHeaderView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "To Account"
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemGray
    }
    
    func layout() {
        addSubview(headerLabel)
        addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.widthAnchor.constraint(equalTo: widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

