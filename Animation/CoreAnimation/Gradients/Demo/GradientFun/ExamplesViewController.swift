//
//  RadialViewController.swift
//  GradientFun
//
//  Created by jrasmusson on 2021-01-31.
//

import UIKit

class ExamplesViewController: UIPageViewController {

    var pages = [UIViewController]()
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let page1 = LinearGradientViewController()
        let page2 = RadialCAGradientViewController()
        let page3 = RadialCGGradientViewController()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSources

extension ExamplesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap to last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap to first
        }
    }
}

// MARK: - Linear

class LinearGradientView: UIView {
    
    let topColor: UIColor = UIColor.lightBlue
    let bottomColor: UIColor = UIColor.lightPurple
    
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
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

class LinearGradientViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view = LinearGradientView()
    }
}

// MARK: - Radial using CAGradientLayer

class RadialCAGradientViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor.systemOrange.cgColor,
            UIColor.systemRed.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = view.bounds
        
        view.layer.addSublayer(gradientLayer)
    }
}


// MARK: - Radial using Core Graphics

class RadialGradientLayer: CALayer {
    
    @objc public var colors = [UIColor.systemRed.cgColor, UIColor.systemBlue.cgColor] {
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
    
    let darkestColor: UIColor = .radialDarkestBlue
    let darkerColor: UIColor = .radialDarkerBlue
    let lighterColor: UIColor = .radialLighterBlue
    let lightestColor: UIColor = .radialLightestBlue
    
    let gradientLayer = RadialGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
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

class RadialCGGradientViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view = RadialGradientView()
    }
}
