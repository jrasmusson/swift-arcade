# Diffable Data Source

### A common pattern used in WWDC examples

WWDC code liks to create initializers that take closures as input arguments.

```swift
class WIFIController {
    typealias UpdateHandler = (WIFIController) -> Void
    private let updateHandler: UpdateHandler
    
    init(updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
    }
}

class WiFiSettingsViewController: UIViewController {
    
    var wifiController: WIFIController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    func configureDataSource() {
        wifiController = WIFIController { [weak self] (controller: WIFIController) in
            guard let self = self else { return }
            self.updateUI()
        }
    }
    
    func updateUI() {
        print("Update")
    }
}
```

While strange looking at first, it is quite elegant. Basically you create _Controllers_ for handling your diffable data. Only when you create them, you pass in an _UpdateHandler_ which is an alias to a closure defined like this.

`typealias UpdateHandler = (WIFIController) -> Void`

which passes itself in as an input and returns nothing. What this effectively does is when the controller does an update, it executes this code passing itself in. This is how the WWDC callback when the WIFI settings change, thus allowing the _ WiFiSettingsViewController_ to update it's UI.


### Links that help

- [Apple WWDC 2019](https://developer.apple.com/videos/play/wwdc2019/220/)