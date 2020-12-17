//
//  HomeViewController.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let button = makeButton(withText: "Scan")
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        title = "Home"
        view.backgroundColor = .systemRed
        setTabBarImage(imageName: "house.fill", title: "Home")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
        layout()
    }
}

extension HomeViewController {
    func setup() {
        
        /*
         If I wanted to handle this target action myself, would make `self` target
         and handle like any other button action. Need to define selector here
         */
        button.addTarget(self, action: #selector(performScanAction(sender:)), for: .primaryActionTriggered)

        /*
         But if I want to fire it up the responder chain, and let someone else handle it,
         I can define a protocol and add it to selector via extension, and set target = `nil`.
         
         In this case I want the `MainViewController` to intercept and handle this request
         and present the `ScanViewController` as a result of this button press.
         So I need to go implement this method there.
         
         By leaving both commented in the event will be handled in both places.
         */
        button.addTarget(nil, action: .didTapScan, for: .primaryActionTriggered)
        
    }
    
    func layout() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func performScanAction(sender: Any?) {
        print("I got this.")
    }
}

// Syntactic sugar to make our code look nicer.
public extension Selector {
    static let didTapHome = #selector(StarBucksResponder.didTapHome(sender:))
    static let didTapScan = #selector(StarBucksResponder.didTapScan(sender:))
}
