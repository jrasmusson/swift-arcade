//
//  FormView.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-17.
//

import Foundation
import UIKit

class FormView: UIView {
    
    let textField = UITextField()
    let lockView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 100)
    }
}

extension FormView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
    }
}
