//
//  GradientView.swift
//  GradientFun
//
//  Created by Rasmusson, Jonathan on 2021-01-30.
//

import UIKit

class GradientView: UIView {
      
    var startColor: UIColor = .white
    var endColor: UIColor = .black
    var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)

    private let gradientLayerName = "Gradient"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupGradient()
    }
    
    private func setupGradient() {
        var gradient: CAGradientLayer? = layer.sublayers?.first { $0.name == gradientLayerName } as? CAGradientLayer
        if gradient == nil {
            gradient = CAGradientLayer()
            gradient?.name = gradientLayerName
            layer.addSublayer(gradient!)
        }

        gradient?.startPoint = startPoint
        gradient?.endPoint = endPoint
        gradient?.frame = bounds
        gradient?.colors = [startColor.cgColor, endColor.cgColor]
        gradient?.zPosition = -1
    }
}

