# Navigation Patterns 🕹

## Modal

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/images/navigation/modal.gif)

Modal ViewControllers are presented modally to uses on the screen. 

```swift
@objc func presentPressed() {
    let viewController = ModalViewController2()
    present(viewController, animated: true, completion: nil)
}

@objc func dismissPressed() {
    dismiss(animated: true, completion: nil)
}
```


## Container

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/images/navigation/container.gif)


Containers (UINavigationController, UITabBarController, UIPageViewController) are ViewControllers Apple has made to make our lives easier for doing default navigation in UIKit.

UINavigationController and UITabBarController are so core to UIViewController that they are actual properties you can access. You pusn and pop off a UINavigationController like this.

```swift
@objc func pushPressed() {
    if let navigationController = navigationController {
        let viewController = NavigationViewController2()
        navigationController.pushViewController(viewController, animated: true)
    }
}

@objc func popPressed() {
    if let navigationController = navigationController {
        navigationController.popViewController(animated: true)
    }
}
```


## Custom

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/images/navigation/custom.gif)

For those cases where Apple's container viewControllers don't cut it, we can create our own. Here we need make sure we follow these three steps whenever we present or dismiss a new viewController embedded in another.

```swift
func presentNextState(viewController: UIViewController) {
    // The view controller we want to present embedded in our navigationViewController
    navigationViewController.setViewControllers([nextViewController], animated: true)

    //
    // x3 things we need to do when adding child view Controller
    //

    // 1. Move the child view controller's view to the parent's view.
    view.addSubview(navigationViewController.view)

    // 2. Add the view controller as a child.
    addChild(navigationViewController)

    // 3. Notify the child that it was moved to a parent.
    navigationViewController.didMove(toParent: self)
}
```

### Links that help

- [Apple Container Views](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)
- [Custom Container Example](https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/)
- [Using Child View Controllers](https://www.swiftbysundell.com/articles/using-child-view-controllers-as-plugins-in-swift/)
