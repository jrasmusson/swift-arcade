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
        let page2 = CustomColorViewController()

        pages.append(page1)
        pages.append(page2)
        
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

// MARK: - Example ViewControllers and Views

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

