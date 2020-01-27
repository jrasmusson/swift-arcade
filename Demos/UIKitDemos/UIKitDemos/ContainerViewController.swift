//
//  CustomContainer.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

///
/// This is an example of Container views in iOS.
///
/// - All state and transitions contained and managed in `ContainerViewController`
/// - State tracked in `NavigationState` enum
/// - Next state communicated up via Responder Chain from child view controllers
///
import UIKit

@objc // Responder Chain
protocol ContainerViewControllerResponder {
    func didPressPrimaryCTAButton(_ sender: Any?)
    func didPressSecondaryCTAButton(_ sender: Any?)
}

class ContainerViewController: UIViewController {

    enum NavigationState {
        case readyToActivate
        case activating
        case success
        case failure
    }

    private var navigationState: NavigationState = .readyToActivate
    private let navigationViewController: UINavigationController
    private var nextViewController = UIViewController()

    init() {
        self.navigationViewController = UINavigationController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        navigationViewController.isNavigationBarHidden = true
        showNextNavigationState(navigationState, animated: false)
    }

    func showNextNavigationState(_ nextNavigationState: NavigationState, animated: Bool = true) {
        self.navigationState = nextNavigationState

        switch navigationState {

        case .readyToActivate:
            nextViewController = ReadyToActivateViewController()
        case .activating:

            ActivationManager.activateAndPoll { result in
                switch result {
                case .success:
                    self.navigationState = .success
                    self.nextViewController = SuccessViewController()
                case .failure(_):
                    self.navigationState = .failure
                    self.nextViewController = FailureViewController()
                }
            }

        case .success:
            nextViewController = SuccessViewController()
        case .failure:
            nextViewController = FailureViewController()
        }

        presentNextState(viewController: nextViewController)
    }

    func presentNextState(viewController: UIViewController) {
        // The view controller we want to present (embedded in nav controller)
        navigationViewController.setViewControllers([nextViewController], animated: true)

        // The x3 things we need to do when presented a child view controller within a parent
        view.addSubview(navigationViewController.view)
        addChild(navigationViewController)
        navigationController?.didMove(toParent: self)
    }
}

extension ContainerViewController: ContainerViewControllerResponder {

    func didPressPrimaryCTAButton(_ sender: Any?) {
        switch navigationState {
        case .readyToActivate:
            showNextNavigationState(.activating)
        case .activating:
            showNextNavigationState(.success)
        case .success:
            dismiss(animated: true, completion: nil)
        case .failure:
            showNextNavigationState(.readyToActivate)
            break
        }
    }

    func didPressSecondaryCTAButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}


