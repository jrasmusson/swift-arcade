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
        // The view controller we want to present embedded in our navigationViewController
        navigationViewController.setViewControllers([nextViewController], animated: true)

        //
        // x3 things we need to do when adding child view Controller
        //

        // Move the child view controller's view to the parent's view
        view.addSubview(navigationViewController.view)

        // Add the view controller as a child
        addChild(navigationViewController)

        // Notify the child that it was moved to a parent
        navigationViewController.didMove(toParent: self)
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
            popViewController()
        case .failure:
            showNextNavigationState(.readyToActivate)
            break
        }
    }

    func didPressSecondaryCTAButton(_ sender: Any?) {
        popViewController()
    }

    private func popViewController() {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }

        // Discussion
        //   If we havd presented viewControlled modally (via present) we could use
        //     dismiss(animated: true, completion: nil)
        //   But because we are embedded within a navigationController, we need to pop.
    }
}


