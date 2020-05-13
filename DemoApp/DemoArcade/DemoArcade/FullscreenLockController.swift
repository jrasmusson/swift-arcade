//
//  FullscreenLockController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

private struct Config {
    public static let fadeDuration = 0.3
}

class FullscreenLockController: UIViewController {
    let loadingVC = LoadingViewController()
    let retryVC = RetryViewController()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        buildSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildSubviews() {
        addLockingView(viewController: retryVC)
        addLockingView(viewController: loadingVC)

        loadingVC.view.alpha = 0
        retryVC.view.alpha = 0
    }

    @objc func setToRetry() {
        view.bringSubviewToFront(retryVC.view)
        UIView.animate(withDuration: Config.fadeDuration) {
            self.loadingVC.view.alpha = 0
        }
        retryVC.view.alpha = 1
    }

    func setToLoading() {
        view.bringSubviewToFront(loadingVC.view)
        retryVC.view.alpha = 0
        loadingVC.view.alpha = 1
    }

    func doneLoading() {
        UIView.animate(withDuration: Config.fadeDuration) {
            self.retryVC.view.alpha = 0
            self.loadingVC.view.alpha = 0
        }
    }

    @objc func addLockingView(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

