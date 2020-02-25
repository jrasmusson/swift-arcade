# Responder Chain

![TableView](https://github.com/jrasmusson/swift-arcade/blob/master/CommunicationPatterns/images/protocol-demo.gif)

Fire it 

```swift
@objc func responderPressed() {

    UIApplication.shared.sendAction(
        #selector(ResponderAction.fetchWeather), to: nil, // target = nil
        from: self, for: nil)

}
```

Catch it.

```swift
extension ResponderChainViewController: ResponderAction {
    @objc func fetchWeather(sender: Any?) {
        print("Fetching weather!")

        let alertController = UIAlertController(title: "Today's weather", message: "Cloudy with a chance of meatballs.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in

        }))

        present(alertController, animated: true, completion: nil)
    }
}

extension UIWindow: ResponderAction {
    @objc func fetchWeather(sender: Any?) {
        print("Fetching weather UIWindow!")
    }
}
```

### Source

```swift
import UIKit

class ResponderChainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Responder Chain"

        view.addSubview(responderButton)

        responderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        responderButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
    }

    let responderButton: UIButton = {
        let button = makeButton(withText: "Fire Responder")
        button.addTarget(self, action: #selector(responderPressed), for: .primaryActionTriggered)
        return button
    }()

    @objc func responderPressed() {

        UIApplication.shared.sendAction(
            #selector(ResponderAction.fetchWeather), to: nil, // target = nil
            from: self, for: nil)

    }
}

@objc protocol ResponderAction: AnyObject {
    func fetchWeather(sender: Any?)
}
```

### Video

- https://www.youtube.com/watch?v=le7tzeqN908

