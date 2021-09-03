# UIPanGestureRecognizer

You basically define the gesture.

```swift
    lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
        return recognizer
    }()
```

Assign it the view you want to pan.

```swift
myView.addGestureRecognizer(panRecognizer)
```

And then in the action, track the _velocity_ (points/second) and _translation_.
_translation_ is the total distance from the inital tap (not the delta). This is 
also a continuous gesture (not a discrete one).

Main thing to note is you want to get the view being panned from the recognizer (not the viewController it was defined in).

## Source

```swift
import UIKit

class MovingBlock: UIViewController {
    
    var myView = UIView()
    var animator = UIViewPropertyAnimator()
    
    lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        myView.addGestureRecognizer(panRecognizer)
    }
    
    func setup() {
        view.backgroundColor = .white
    }
    
    func layout() {
        myView = makeView()
        view.addSubview(myView)
        
        myView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func makeView() -> UIView {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemBlue
        
        return myView
    }
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let piece = recognizer.view else { return }
        
        let translation = recognizer.translation(in: piece.superview)
        let velocity = recognizer.velocity(in: piece.superview)
        
        switch recognizer.state {
        case .began:
            print("began translation:\(translation) \(velocity)")
            self.initialCenter = piece.center
        case .changed:
            print("changed translation:\(translation) \(velocity)")
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        case .ended:
            print("ended translation:\(translation) \(velocity)")
        default:
            print("default")
        }
    }
}
```

### Links that help

- [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer)
- [Handling Pan Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures)


### Video

- [Popup Menu with UIPanGestureRecognizer and UIViewPropertyAnimator](https://www.youtube.com/watch?v=K9EK3B_X4LM)

