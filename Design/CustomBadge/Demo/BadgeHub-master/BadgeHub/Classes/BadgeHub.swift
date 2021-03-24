//
//  BadgeHub.swift
//
//  Created by Jogendra on 31/05/19.
//  Copyright © 2019 Jogendra. All rights reserved.
//

import UIKit
import QuartzCore

fileprivate class BadgeView: UIView {
    
    func setBackgroundColor(_ backgroundColor: UIColor?) {
        super.backgroundColor = backgroundColor
    }
}

/// A way to quickly add a notification badge icon to any view.
/// Make any view of a full-fledged animated notification center.
public class BadgeHub: NSObject {
    
    /// Value of current count on badge.
    var count: Int = 0 {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
            resizeToFitDigits()
        }
    }
    /// Maximum count can be set on badge.
    var maxCount: Int = 0
    
    var hubView: UIView?
    
    private var curOrderMagnitude: Int = 0
    private var countLabel: UILabel? {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
        }
    }
    
    private var redCircle: BadgeView!
    private var initialCenter = CGPoint.zero
    private var baseFrame = CGRect.zero
    private var initialFrame = CGRect.zero
    
    private struct Constants {
        static let notificHubDefaultDiameter: CGFloat = 30
        static let countMagnitudeAdaptationRatio: CGFloat = 0.3
        // Pop values
        static let popStartRatio: CGFloat = 0.85
        static let popOutRatio: CGFloat = 1.05
        static let popInRatio: CGFloat = 0.95
        // Blink values
        static let blinkDuration: CGFloat = 0.1
        static let blinkAlpha: CGFloat = 0.1
        // Bump values
        static let firstBumpDistance: CGFloat = 8.0
        static let bumpTimeSeconds: CGFloat = 0.13
        static let secondBumpDist: CGFloat = 4.0
        static let bumpTimeSeconds2: CGFloat = 0.1
    }
    
    
    /// Set badge to view. It set default count to `0` and `maxCount` to 100000.
    /// To set count other than `0`, use `setView` method.
    /// - Parameter view: The view on which badge to be set.
    public init(view: UIView) {
        super.init()
        
        maxCount = 100000
        setView(view, andCount: 0)
    }
    
    /// Initializer for setting badge to bar button items
    /// - Parameter barButtonItem: Bar button item on which badge to be add.
    public convenience init?(barButtonItem: UIBarButtonItem) {
        if let value = barButtonItem.value(forKey: "view") as? UIView {
            self.init(view: value)
            scaleCircleSize(by: 0.7)
            moveCircleBy(x: -5.0, y: 0)
        } else if let value = barButtonItem.customView {
            self.init(view: value)
            scaleCircleSize(by: 0.7)
            moveCircleBy(x: -5.0, y: 0)
        } else {
            return nil
        }
    }
    
    /// Set a view to badgehub.
    /// - Parameters:
    ///   - view: The view on which badge to be added.
    ///   - startCount: Initial count to be shown on view.
    public func setView(_ view: UIView?, andCount startCount: Int) {
        curOrderMagnitude = 0
        
        let frame: CGRect? = view?.frame
        
        redCircle = BadgeView()
        redCircle?.isUserInteractionEnabled = false
        redCircle.backgroundColor = UIColor.red
        
        countLabel = UILabel(frame: redCircle.frame)
        countLabel?.isUserInteractionEnabled = false
        count = startCount
        countLabel?.textAlignment = .center
        countLabel?.textColor = UIColor.white
        countLabel?.backgroundColor = UIColor.clear
        
        setCircleAtFrame(CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                                y: (-Constants.notificHubDefaultDiameter) / 3,
                                width: CGFloat(Constants.notificHubDefaultDiameter),
                                height: CGFloat(Constants.notificHubDefaultDiameter)))
        
        view?.addSubview(redCircle)
        view?.addSubview(countLabel!)
        view?.bringSubviewToFront(redCircle)
        view?.bringSubviewToFront(countLabel!)
        hubView = view
        checkZero()
    }
    
    /// Set the frame of the notification circle relative to the view.
    public func setCircleAtFrame(_ frame: CGRect) {
        redCircle.frame = frame
        initialCenter = CGPoint(x: frame.origin.x + frame.size.width / 2,
                                y: frame.origin.y + frame.size.height / 2)
        baseFrame = frame
        initialFrame = frame
        countLabel?.frame = redCircle.frame
        redCircle.layer.cornerRadius = frame.size.height / 2
        countLabel?.font = UIFont.systemFont(ofSize: frame.size.width / 2)
    }
    
    /// Change the color of the notification circle.
    /// - Parameters:
    ///   - circleColor: Color of badge dot (background).
    ///   - labelColor: Color of count label.
    public func setCircleColor(_ circleColor: UIColor?, label labelColor: UIColor?) {
        redCircle.backgroundColor = circleColor
        if let labelColor = labelColor {
            countLabel?.textColor = labelColor
        }
    }
    
    /// Change the border color and border width of the circle.
    /// - Parameters:
    ///   - color: Border color for circle.
    ///   - width: Border width.
    public func setCircleBorderColor(_ color: UIColor?, borderWidth width: CGFloat) {
        redCircle.layer.borderColor = color?.cgColor
        redCircle.layer.borderWidth = width
    }
    
    /// Move the circle (left/right or up/down).
    /// - Parameters:
    ///   - x: Move circle to left/rigth.
    ///   - y: Move circle to up/down.
    public func moveCircleBy(x: CGFloat, y: CGFloat) {
        var frame: CGRect = redCircle.frame
        frame.origin.x += x
        frame.origin.y += y
        self.setCircleAtFrame(frame)
    }
    
    /// Changes the size of the circle.
    /// - Parameter scale: Scale factor. Setting a scale of 1 has no effect.
    public func scaleCircleSize(by scale: CGFloat) {
        let fr: CGRect = initialFrame
        let width: CGFloat = fr.size.width * scale
        let height: CGFloat = fr.size.height * scale
        let wdiff: CGFloat = (fr.size.width - width) / 2
        let hdiff: CGFloat = (fr.size.height - height) / 2
        
        let frame = CGRect(x: fr.origin.x + wdiff,
                           y: fr.origin.y + hdiff,
                           width: width, height: height)
        self.setCircleAtFrame(frame)
    }
    
    /// Increases count by 1
    public func increment() {
        increment(by: 1)
    }
    
    /// Increases count by amount.
    /// - Parameter amount: Increment count.
    public func increment(by amount: Int) {
        count += amount
    }
    
    /// Decreases count by 1
    public func decrement() {
        decrement(by: 1)
    }
    
    /// Decreases count by amount.
    /// If the count after decrement become `<= 0`, it hide the badge.
    /// - Parameter amount: Decrement count.
    public func decrement(by amount: Int) {
        if amount >= count {
            count = 0
            return
        }
        count -= amount
        checkZero()
    }
    
    /// Hide badge from your view.
    public func hide() {
        redCircle.isHidden = true
        countLabel?.isHidden = true
    }
    
    /// Show hidden badge on your view.
    public func show() {
        redCircle.isHidden = false
        countLabel?.isHidden = false
    }
    
    /// Hide the count (Blank Bedge).
    /// Remember this only hide count,
    /// and not the red dot.
    public func hideCount() {
        redCircle.isHidden = true
    }
    
    /// Show count again on the badge.
    /// It hides the badge if current count is `<= 0`.
    public func showCount() {
        checkZero()
    }
    
    /// Get value of current count on badge.
    /// - Returns: Current count.
    public func getCurrentCount() -> Int {
        return self.count
    }
    
    /// Set max count which can be displayed.
    /// This method can be used to restrict
    /// the maximum count can be set on the badge.
    /// - Parameter count: Count value.
    public func setMaxCount(to count: Int) {
        self.maxCount = count
    }
    
    /// Apply pop animation to the badge.
    public func pop() {
        let height = baseFrame.size.height
        let width = baseFrame.size.width
        let popStartHeight: Float = Float(height * Constants.popStartRatio)
        let popStartWidth: Float = Float(width * Constants.popStartRatio)
        let timeStart: Float = 0.05
        let popOutHeight: Float = Float(height * Constants.popOutRatio)
        let popOutWidth: Float = Float(width * Constants.popOutRatio)
        let timeOut: Float = 0.2
        let popInHeight: Float = Float(height * Constants.popInRatio)
        let popInWidth: Float = Float(width * Constants.popInRatio)
        let timeIn: Float = 0.05
        let popEndHeight: Float = Float(height)
        let popEndWidth: Float = Float(width)
        let timeEnd: Float = 0.05
        
        let startSize = CABasicAnimation(keyPath: "cornerRadius")
        startSize.duration = CFTimeInterval(timeStart)
        startSize.beginTime = 0
        startSize.fromValue = NSNumber(value: popEndHeight / 2)
        startSize.toValue = NSNumber(value: popStartHeight / 2)
        startSize.isRemovedOnCompletion = false
        
        let outSize = CABasicAnimation(keyPath: "cornerRadius")
        outSize.duration = CFTimeInterval(timeOut)
        outSize.beginTime = CFTimeInterval(timeStart)
        outSize.fromValue = startSize.toValue
        outSize.toValue = NSNumber(value: popOutHeight / 2)
        outSize.isRemovedOnCompletion = false
        
        let inSize = CABasicAnimation(keyPath: "cornerRadius")
        inSize.duration = CFTimeInterval(timeIn)
        inSize.beginTime = CFTimeInterval(timeStart + timeOut)
        inSize.fromValue = outSize.toValue
        inSize.toValue = NSNumber(value: popInHeight / 2)
        inSize.isRemovedOnCompletion = false
        
        let endSize = CABasicAnimation(keyPath: "cornerRadius")
        endSize.duration = CFTimeInterval(timeEnd)
        endSize.beginTime = CFTimeInterval(timeIn + timeOut + timeStart)
        endSize.fromValue = inSize.toValue
        endSize.toValue = NSNumber(value: popEndHeight / 2)
        endSize.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.duration = CFTimeInterval(timeStart + timeOut + timeIn + timeEnd)
        group.animations = [startSize, outSize, inSize, endSize]
        
        redCircle.layer.add(group, forKey: nil)
        
        UIView.animate(withDuration: TimeInterval(timeStart), animations: {
            var frame: CGRect = self.redCircle.frame
            let center: CGPoint = self.redCircle.center
            frame.size.height = CGFloat(popStartHeight)
            frame.size.width = CGFloat(popStartWidth)
            self.redCircle.frame = frame
            self.redCircle.center = center
        }) { complete in
            UIView.animate(withDuration: TimeInterval(timeOut), animations: {
                var frame: CGRect = self.redCircle.frame
                let center: CGPoint = self.redCircle.center
                frame.size.height = CGFloat(popOutHeight)
                frame.size.width = CGFloat(popOutWidth)
                self.redCircle.frame = frame
                self.redCircle.center = center
            }) { complete in
                UIView.animate(withDuration: TimeInterval(timeIn), animations: {
                    var frame: CGRect = self.redCircle.frame
                    let center: CGPoint = self.redCircle.center
                    frame.size.height = CGFloat(popInHeight)
                    frame.size.width = CGFloat(popInWidth)
                    self.redCircle.frame = frame
                    self.redCircle.center = center
                }) { complete in
                    UIView.animate(withDuration: TimeInterval(timeEnd), animations: {
                        var frame: CGRect = self.redCircle.frame
                        let center: CGPoint = self.redCircle.center
                        frame.size.height = CGFloat(popEndHeight)
                        frame.size.width = CGFloat(popEndWidth)
                        self.redCircle.frame = frame
                        self.redCircle.center = center
                    })
                }
            }
        }
    }
    
    
    /// Apply `Blink` animation to the badge.
    public func blink() {
        self.setAlpha(alpha: Constants.blinkAlpha)
        
        UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
            self.setAlpha(alpha: 1)
        }) { complete in
            UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
                self.setAlpha(alpha: Constants.blinkAlpha)
            }) { complete in
                UIView.animate(withDuration: TimeInterval(Constants.blinkDuration), animations: {
                    self.setAlpha(alpha: 1)
                })
            }
        }
    }
    
    /// Animation that jumps similar to macOS dock icons.
    public func bump() {
        if !initialCenter.equalTo(redCircle.center) {
            // cancel previous animation
        }
        
        bumpCenterY(yVal: 0)
        UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds), animations: {
            self.bumpCenterY(yVal: Constants.firstBumpDistance)
        }) { complete in
            UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds), animations: {
                self.bumpCenterY(yVal: 0)
            }) { complete in
                UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds2), animations: {
                    self.bumpCenterY(yVal: Constants.secondBumpDist)
                }) { complete in
                    UIView.animate(withDuration: TimeInterval(Constants.bumpTimeSeconds2), animations: {
                        self.bumpCenterY(yVal: 0)
                    })
                }
            }
        }
    }
    
    /// Set the count yourself.
    /// - Parameter newCount: New count to be set to badge.
    public func setCount(_ newCount: Int) {
        self.count = newCount
        let labelText = count > maxCount ? "\(maxCount)+" : "\(count)"
        countLabel?.text = labelText
        checkZero()
    }
    
    /// Set the font of the label.
    public func setCountLabelFont(_ font: UIFont?) {
        countLabel?.font = font
    }
    
    /// Get current set label font for count label.
    /// - Returns: current set font.
    public func getCountLabelFont() -> UIFont? {
        return countLabel?.font
    }
    
    /// Bump badge up or down.
    /// - Parameter yVal: `Y` coordinate for bumps.
    public func bumpCenterY(yVal: CGFloat) {
        var center: CGPoint = redCircle.center
        center.y = initialCenter.y - yVal
        redCircle.center = center
        countLabel?.center = center
    }
    
    /// Set alpha to badge.
    /// - Parameter alpha: Alpha value for red circle and count.
    public func setAlpha(alpha: CGFloat) {
        redCircle.alpha = alpha
        countLabel?.alpha = alpha
    }
    
    /// Method to hide badge in case of current `count <= 0` and
    /// show badge in case of current `cout > 0`.
    /// Use this method explicitaly when your badge is not hiding/showing as expected.
    public func checkZero() {
        if count <= 0 {
            redCircle.isHidden = true
            countLabel?.isHidden = true
        } else {
            redCircle.isHidden = false
            countLabel?.isHidden = false
        }
    }
    
    /// Resize the badge to fit the current digits.
    /// This method is called everytime count value is changed.
    func resizeToFitDigits() {
        guard count > 0 else { return }
        var orderOfMagnitude: Int = Int(log10(Double(count)))
        orderOfMagnitude = (orderOfMagnitude >= 2) ? orderOfMagnitude : 1
        var frame: CGRect = initialFrame
        frame.size.width = CGFloat(initialFrame.size.width * (1 + 0.3 * CGFloat(orderOfMagnitude - 1)))
        frame.origin.x = initialFrame.origin.x - (frame.size.width - initialFrame.size.width) / 2
        
        redCircle.frame = frame
        initialCenter = CGPoint(x: frame.origin.x + frame.size.width / 2,
                                y: frame.origin.y + frame.size.height / 2)
        baseFrame = frame
        countLabel?.frame = redCircle.frame
        curOrderMagnitude = orderOfMagnitude
    }
}
