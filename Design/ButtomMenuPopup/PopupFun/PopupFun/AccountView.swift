//
//  AccountView.swift
//  PopupFun
//
//  Created by jrasmusson on 2021-03-09.
//

import Foundation
import UIKit

protocol AccountViewDelegate: AnyObject {
    func didTap(_ sender: AccountView)
}

class AccountView: UIView {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dividerView = UIView()
    
    weak var delegate: AccountViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 32)
    }
}

extension AccountView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.circle")
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "To"
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .black
    }
    
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapped(_: )))
        addGestureRecognizer(singleTap)
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTap(self)
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 2),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: contentLabel.trailingAnchor, multiplier: 2),
            dividerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        imageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

