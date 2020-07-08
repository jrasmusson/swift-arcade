# Starbucks App ☕

This walk through shows you some of the architecture, mechanics, and designs that went into building the Starbucks application.

## High-Level Architecture

The Starbucks app is made up for various view controllers, each containing their own navigation bar.

![](images/high-level-architecture1.png)
![](images/high-level-architecture2.png)

We can set this up in our `AppDelegate` and present in our main `Window` like this.

**AppDelegate.swift**

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
                
        let homeVC = HomeViewController()
        let scanVC = ScanViewController()
        let orderVC = OrderViewController()
        let giftVC = GiftViewController()
        let storeVC = StoreViewController()
                
        let homeNC = UINavigationController(rootViewController: homeVC)
        let scanNC = UINavigationController(rootViewController: scanVC)
        let orderNC = UINavigationController(rootViewController: orderVC)
        let giftNC = UINavigationController(rootViewController: giftVC)
        let storeNC = UINavigationController(rootViewController: storeVC)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNC, scanNC, orderNC, giftNC, storeNC]

        window?.rootViewController = tabBarController
        
        return true
    }
 }
```

## Collapsible Header

The home screen has a header that collapses and expands as you swipe up and down.

![](images/collapsible-header.gif)

![](images/detecting-the-scroll.png)

![](images/making-it-snap.png)

To get this affect first build a custom header.

**HomeHeaderView.swift**

```swift
import UIKit

class HomeHeaderView: UIView {
    
    let greeting = UILabel()
    let inboxButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderView {
    func layout() {
        
        greeting.translatesAutoresizingMaskIntoConstraints = false
        greeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greeting.text = "Good afternoon, Jonathan ☀️"
        greeting.numberOfLines = 0
        greeting.lineBreakMode = .byWordWrapping
        
        inboxButton.translatesAutoresizingMaskIntoConstraints = false
        inboxButton.setTitleColor(.label, for: .normal)
        inboxButton.setTitle("Inbox", for: .normal)
        
        addSubview(greeting)
        addSubview(inboxButton)
        
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            greeting.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: greeting.trailingAnchor, multiplier: 2),
            
            inboxButton.topAnchor.constraint(equalToSystemSpacingBelow: greeting.bottomAnchor, multiplier: 2),
            inboxButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: inboxButton.bottomAnchor, multiplier: 1)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
```

Then make it collapse and snap by tying the scroll offset to the height of the header via an auto layout constraint.

**HomeViewController.swift**

```swift
// MARK: Animating scrollView
extension HomeViewController: UITableViewDelegate {
    
    // Snap to position
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y

        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let labelHeight = headerView.greeting.frame.height + 16 // label + spacer (102)

        UIView.animate(withDuration: 0.3) {
            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = shouldSnap ? -labelHeight : 0
            self.view.layoutIfNeeded()
        })
    }
 }
 ```



