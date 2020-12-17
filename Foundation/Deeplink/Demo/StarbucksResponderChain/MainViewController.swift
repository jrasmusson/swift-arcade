//
//  MainViewController.swift
//  StarbucksResponderChain
//
//  Created by jrasmusson on 2020-12-12.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    let sbTabBarController = UITabBarController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
        present()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainViewController {
    func setup() {
        let homeVC = HomeViewController()
        let scanVC = ScanViewController()
                
        let homeNC = UINavigationController(rootViewController: homeVC)
        let scanNC = UINavigationController(rootViewController: scanVC)

        sbTabBarController.viewControllers = [homeNC, scanNC]
    }
    
    func present() {
        // This is how you add child VC to parent - x3 things
        addChild(sbTabBarController)
        view.addSubview(sbTabBarController.view)
        didMove(toParent: self)
    }
}

// MARK: Responder chain events

extension MainViewController: StarBucksResponder {
    func didTapScan(sender: UIButton?) {
        
        // remove currently displayed children VCs
        let existingChildren = children

        for child in existingChildren {
            child.remove()
        }
        
        // add new one we want to present
        sbTabBarController.selectedIndex = 1 // Scan
        add(sbTabBarController)
    }
}

// MARK: Deep Link

extension MainViewController {
    
    /*
     Here I could manually navigate to whatever view I want.
     Or I could hook into our existing responder chain and fire up the event and navigate that way.
     */
    func handleDeepLink(_ deepLink: DeepLink) {
        switch deepLink {
        case .home:
            UIApplication.shared.sendAction(.didTapHome, to: nil, from: self, for: nil)
        case .scan:
            UIApplication.shared.sendAction(.didTapScan, to: nil, from: self, for: nil)
        }
    }
}
