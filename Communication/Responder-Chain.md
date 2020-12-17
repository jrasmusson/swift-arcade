# Responder Chain

## How to fire manually

```swift
@objc protocol ActivationTileActions {
    func performSetupYourModemAction(sender: Any?)
}

extension ActivationTileViewController: ActivationTileRowButtonViewDelegate {

    func didPressButton(_ sender: Any?) {
        UIApplication.shared.sendAction(#selector(ActivationTileActions.performSetupYourModemAction), to: nil, from: self, for: nil)
    }
}
```

![TableView](images/protocol-demo.gif)


```swift
import UIKit

/*
 The ResponderChain fires UIEvents up the Responder chain stack giving each UIResponder
 a chance to handle.

 The subtile difference in target is whether you set yourself, or `nil`.

 If you set `self` as the target, you will get a chance to intercept the responder chain call, and either
 handle it or refire it up the chain again with `UIApplication.shared.sendAction`.

    > button.addTarget(self, action: #selector(responderPressed(sender:)), for: .primaryActionTriggered)

 If you set the target as `nil` initially, the event will continue to walk up the chain, calling `next`, one
 every responder it meets, until it finds one that satisfier the action.

    > button.addTarget(nil, action: .performFetchWeatherAction, for: .primaryActionTriggered)

 */
class ResponderChainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    let sharedActionButton: UIButton = {
        let button = makeButton(withText: "UIApplication.shared")
        button.addTarget(self, action: #selector(responderPressed(sender:)), for: .primaryActionTriggered)
        return button
    }()

    let planActionButton: UIButton = {
        let button = makeButton(withText: "button.addTarget(nil)")
        button.addTarget(nil, action: .performFetchWeatherAction, for: .primaryActionTriggered)
        return button
    }()

    func setupViews() {
        navigationItem.title = "Responder Chain"

        let stackView = makeVerticalStackView()
        stackView.addArrangedSubview(sharedActionButton)
        stackView.addArrangedSubview(planActionButton)

        view.addSubview(stackView)

        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
    }

    @objc func responderPressed(sender: Any?) {
        UIApplication.shared.sendAction(
            #selector(ResponderAction.fetchWeather), to: nil, // target = nil
            from: self, for: nil)
    }
}

@objc protocol ResponderAction: AnyObject {
    func fetchWeather(sender: Any?)
}

private extension Selector {
    static let performFetchWeatherAction = #selector(ResponderAction.fetchWeather(sender:))
}
```

## Passing Data

Because responder chain only supports three method signatures

```swift
- (void)action
- (void)action:(id)sender
- (void)action:(id)sender forEvent:(UIEvent *)event
```

We can't pass data like we would in a normal method. It has to be in one of the above forms.

```
func didSelectRowAt(_ indexPath: IndexPath) // 💥 «Unrecognized Selector Sent to Instance» Error In Xcode.
```

What that means is that to pass data, you have to include it as a property in the `sender` sent via the action.

```swift
@objc protocol ListAction: AnyObject {
  func didSelectItem(_ sender: ListViewController)
}

override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
  UIApplication.shared.sendAction(
     #selector(ListAction.didSelectItem(_:)), 
     to: nil, from: self, for: nil)
}

extension RootViewController: ListAction {
  func didSelectItem(_ sender: ListViewController) {
    if let object = sender.selectedObject { // 🚀 Passed data
      // present the detail view controller
    }
}
```
 
### Links that help

- [Using the Responder Chain](https://useyourloaf.com/blog/using-the-responder-chain/)
- [Unrecognized Selectors](https://learnappmaking.com/unrecognized-selector-sent-to-instance-swift-development/)

