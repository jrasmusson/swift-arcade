//
//  DrawRectViewController.swift
//  CoreGraphicsIntro
//
//  Created by jrasmusson on 2021-01-18.
//

import UIKit

class DrawRectViewController: UIViewController {
    
    let drawRectView = DrawRectView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        drawRectView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        label.text = "drawRect gives you full control over what a layer will render. The container view must still define the space that the via is going to draw in (in this case Auto Layout with width and height 512x512). But when it comes to drawing, drawRect uses it's own local coordinate system and renders exactly when it wants where it wants it."
        
        view.addSubview(drawRectView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            drawRectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            drawRectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            drawRectView.widthAnchor.constraint(equalToConstant: 512),
            drawRectView.heightAnchor.constraint(equalToConstant: 512),
            
            label.topAnchor.constraint(equalToSystemSpacingBelow: drawRectView.bottomAnchor, multiplier: 4),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: label.trailingAnchor, multiplier: 4),
        ])
    }
}
