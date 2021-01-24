//
//  ShadowViewController.swift
//  CoreAnimationIntro
//
//  Created by jrasmusson on 2021-01-23.
//

import UIKit

class ShadowViewController: UIViewController {
    
    let stackView = UIStackView()
    
    let simpleShadowView = UIView()
    let pathShadowView = UIView()
    let customView = MyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shadow view"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        simpleShadowView.backgroundColor = .systemBlue
        pathShadowView.backgroundColor = .systemRed
        
        simpleShadowView.translatesAutoresizingMaskIntoConstraints = false
        pathShadowView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(simpleShadowView)
        stackView.addArrangedSubview(pathShadowView)
        stackView.addArrangedSubview(customView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            simpleShadowView.widthAnchor.constraint(equalToConstant: 300),
            simpleShadowView.heightAnchor.constraint(equalToConstant: 200),
            
            pathShadowView.widthAnchor.constraint(equalTo: simpleShadowView.widthAnchor),
            pathShadowView.heightAnchor.constraint(equalTo: simpleShadowView.heightAnchor),
        ])
        
        styleBasic(simpleShadowView)
    }
    
    // For any effects that need bounds, do them in viewDidAppear or when the view has been sized
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        styleShadow()
    }
    
    /*
     To get a simple quick shadow do this.
     */
    func styleBasic(_ viewToStyle: UIView) {
        viewToStyle.layer.cornerRadius = 20
        viewToStyle.layer.shadowOpacity = 0.5
        viewToStyle.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    /*
     To increase performance, you can define your shadow as a path.
     
     Note: Because the path depends on the bounds of your view, you can't call this
     until your view has been sized. So only call this method in viewDidAppear
     or in layoutSubViews of your custom view.
     */
    func styleShadow() {
        pathShadowView.layer.shadowColor = UIColor(white: 0.5, alpha: 1).cgColor
        pathShadowView.layer.shadowRadius = 4.0
        pathShadowView.layer.shadowPath = UIBezierPath(rect: pathShadowView.bounds).cgPath
        pathShadowView.layer.shadowOpacity = 1.0
        pathShadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    class MyView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 200, height: 200)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // do shadow work here once size is known
            addShadow()
        }
        
        func addShadow() {
            layer.shadowColor = UIColor(white: 0.5, alpha: 1).cgColor
            layer.shadowRadius = 4.0
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shadowOpacity = 1.0
            layer.shadowOffset = CGSize(width: 10, height: 10)
        }
    }
}
