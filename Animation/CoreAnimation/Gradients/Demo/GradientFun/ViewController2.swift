//
//  ViewController.swift
//  GradientFun
//
//  Created by jrasmusson on 2021-01-30.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
//        view = LinearGradientView(frame: .zero)
//        view = RadialGradientView(frame: .zero)
        
        let loginView = GradientView()
        loginView.startColor = UIColor.loginLightBlueLine
        loginView.endColor = UIColor.aTBPurple
        loginView.startPoint = CGPoint(x: 0.07, y: -0.15)
        loginView.endPoint = CGPoint(x: 0.0, y: 0.25)

        view = loginView
    }

}

open class LinearGradientView: UIView {
    
    let topColor: UIColor = UIColor(red: 0, green: 152 / 255.0, blue: 202 / 255.0, alpha: 1)
    let bottomColor: UIColor = UIColor(red: 0, green: 106 / 255.0, blue: 152 / 255.0, alpha: 1)
    let gradientLayer = CAGradientLayer()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
    
}

class RadialGradientLayer: CALayer {
    
    @objc public var colors = [UIColor.red.cgColor, UIColor.blue.cgColor] {
        didSet {
            backgroundColor = colors.last
        }
    }
    
    required override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override func draw(in context: CGContext) {
        context.saveGState()
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let endRadius = max(bounds.width, bounds.height) / 2
        
        var locations = [CGFloat]()
        for index in 0...colors.count - 1 {
            locations.append(CGFloat(index) / CGFloat(colors.count - 1))
        }
        
        if let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: locations) {
            context.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        }
    }
}

public class RadialGradientView: UIView {
    
    @objc let darkestColor: UIColor = .shawGradientDarkestBlue
    @objc let darkerColor: UIColor = .shawGradientDarkerBlue
    @objc let lighterColor: UIColor = .shawGradientLighterBlue
    @objc let lightestColor: UIColor = .shawGradientLightestBlue
    @objc let gradientLayer = RadialGradientLayer()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
    
    private func commonInit() {
        backgroundColor = darkestColor
        gradientLayer.colors = [lightestColor.cgColor, lighterColor.cgColor, darkerColor.cgColor, darkestColor.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
}

public extension UIColor { // Gradiants

    private static let _shawGradientDarkestBlue = UIColor(red: 0, green: 106 / 255.0, blue: 152 / 255.0, alpha: 1)
    @objc class var shawGradientDarkestBlue: UIColor {
        return _shawGradientDarkestBlue
    }

    private static let _shawGradientDarkerBlue = UIColor(red: 0, green: 129 / 255.0, blue: 182 / 255.0, alpha: 1)
    @objc class var shawGradientDarkerBlue: UIColor {
        return _shawGradientDarkerBlue
    }

    private static let _shawGradientLighterBlue = UIColor(red: 0, green: 147 / 255.0, blue: 199 / 255.0, alpha: 1)
    @objc class var shawGradientLighterBlue: UIColor {
        return _shawGradientLighterBlue
    }

    private static let _shawGradientLightestBlue = UIColor(red: 0, green: 152 / 255.0, blue: 202 / 255.0, alpha: 1)
    @objc class var shawGradientLightestBlue: UIColor {
        return _shawGradientLightestBlue
    }

}
