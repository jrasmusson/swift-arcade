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

public class BadgeHub: NSObject {
    
    private var curOrderMagnitude: Int = 0
    private var redCircle: BadgeView!
    private var initialCenter = CGPoint.zero
    private var baseFrame = CGRect.zero
    private var initialFrame = CGRect.zero
    
    var hubView: UIView?
    
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

    var count: Int = 0 {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
            resizeToFitDigits()
        }
    }
        
    private var countLabel: UILabel? {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
        }
    }
    
    public init(view: UIView) {
        super.init()
        
        setView(view, andCount: 0)
    }
        
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
        
        let atFrame = CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                             y: (-Constants.notificHubDefaultDiameter) / 3,
                             width: CGFloat(Constants.notificHubDefaultDiameter),
                             height: CGFloat(Constants.notificHubDefaultDiameter))
        setCircleAtFrame(atFrame)
        
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
        baseFrame = frame
        initialFrame = frame
        
        countLabel?.frame = redCircle.frame
        redCircle.layer.cornerRadius = frame.size.height / 2
        countLabel?.font = UIFont.systemFont(ofSize: frame.size.width / 2)
    }
            
    public func moveCircleBy(x: CGFloat, y: CGFloat) {
        var frame: CGRect = redCircle.frame
        frame.origin.x += x
        frame.origin.y += y
        self.setCircleAtFrame(frame)
    }
                            
    public func setCount(_ newCount: Int) {
        self.count = newCount
        countLabel?.text = "\(count)"
        checkZero()
    }
            
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
        
        var frame = initialFrame
        print("frame before: \(frame)")
        frame.size.width = CGFloat(initialFrame.size.width * (1 + 0.3 * CGFloat(orderOfMagnitude - 1)))
        frame.origin.x = initialFrame.origin.x - (frame.size.width - initialFrame.size.width) / 2
        print("frame after: \(frame)")
        
        redCircle.frame = frame
        baseFrame = frame
        countLabel?.frame = redCircle.frame
        curOrderMagnitude = orderOfMagnitude
    }
    
    func setAlpha(alpha: CGFloat) {
        redCircle.alpha = alpha
        countLabel?.alpha = alpha
    }

    /// Bump badge up or down.
    /// - Parameter yVal: `Y` coordinate for bumps.
    func bumpCenterY(yVal: CGFloat) {
        var center: CGPoint = redCircle.center
        center.y = initialCenter.y - yVal
        redCircle.center = center
        countLabel?.center = center
    }

    func increment() {
        increment(by: 1)
    }
    
    func increment(by amount: Int) {
        count += amount
    }

    func decrement() {
        decrement(by: 1)
    }

    func decrement(by amount: Int) {
        if amount >= count {
            count = 0
            return
        }
        count -= amount
        checkZero()
    }

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
}

