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
    private var baseFrame = CGRect.zero
    private var initialFrame = CGRect.zero
    
    var hubView: UIView?
    
    private struct Constants {
        static let notificHubDefaultDiameter: CGFloat = 30
        static let countMagnitudeAdaptationRatio: CGFloat = 0.3
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
}
