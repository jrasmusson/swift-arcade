# Custom Badge

This tutorial will show you how to create your own custom badge and display on any `UIView`. Example based on source code of [BadgeHub](https://github.com/jogendra/BadgeHub).

![](images/11.png)

## Usage

**ViewController.swift**

```swift
import UIKit

class ViewController: UIViewController {
    
    private var hub: BadgeHub?
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: view.frame.size.width / 2 - 48,
                          y: 80, width: 96, height: 96)
        iv.image = UIImage(named: "github_color")
        return iv
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }
    
    private func setupImageView() {
        hub = BadgeHub(view: imageView)
        hub?.setCount(200)
        view.addSubview(imageView)
    }
}
```

You basically create the view you want to add the badge to (in this case a `UIImage`). And then you add the badge to the view by passing it into this object called `BadgeHub` and it takes care of the rest.

It will look at the frame of the view you pass it, create a red circle and label offset up and to the right, and that's basically it.

## How it works

### Placing the circle

![](images/2.png)

The circle is placed in the upper-righthand-corner by taking the frame of the passed in view, and creating a new view for the circle offset from the original by some empirically determined amount (2/3 and 1/3 in this case.

```swift
import UIKit
import QuartzCore

fileprivate class BadgeView: UIView {
    
    func setBackgroundColor(_ backgroundColor: UIColor?) {
        super.backgroundColor = backgroundColor
    }
}

public class BadgeHub: NSObject {
    
    private var redCircle: BadgeView!
    var hubView: UIView?
    
    private struct Constants {
        static let notificHubDefaultDiameter: CGFloat = 30
    }
            
    public init(view: UIView) {
        super.init()
        
        setView(view)
    }
        
    public func setView(_ view: UIView?) {
        let frame: CGRect? = view?.frame
        
        redCircle = BadgeView()
        redCircle?.isUserInteractionEnabled = false
        redCircle.backgroundColor = UIColor.red
        
        let atFrame = CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                             y: (-Constants.notificHubDefaultDiameter) / 3,
                             width: CGFloat(Constants.notificHubDefaultDiameter),
                             height: CGFloat(Constants.notificHubDefaultDiameter))
        setCircleAtFrame(atFrame)
        
        view?.addSubview(redCircle)
        view?.bringSubviewToFront(redCircle)
        hubView = view
    }
    
    /// Set the frame of the notification circle relative to the view.
    public func setCircleAtFrame(_ frame: CGRect) {
        redCircle.frame = frame
        redCircle.layer.cornerRadius = frame.size.height / 2
    }
}
```

All the magic happens on this line here:

```swift
let atFrame = CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                     y: (-Constants.notificHubDefaultDiameter) / 3,
                     width: CGFloat(Constants.notificHubDefaultDiameter),
                     height: CGFloat(Constants.notificHubDefaultDiameter))
setCircleAtFrame(atFrame)

```

It looks complicated, but it's not if you draw it out. The key thing to understand is that the new frame we are creating, the one for the red circle, gets its corrindates relative to the frame passed in.

For example, if we set the coordinates of our new red circle frame to be at the origin (0,0).

```swift
let atFrame = CGRect(x: 0,
                     y: 0,
                     width: ...,
                     height: ...)
```

Our badge would appear here.

![](images/3.png)

To move it up and to the right we need take the original frame size, and subtract from it 2/3 of the circles diameter, nudging it just in from the far right.

![](images/4.png)


### Dealing with order of magnitude numbers

### Links the help

- [BadgeHub - source code for example](https://github.com/jogendra/BadgeHub)