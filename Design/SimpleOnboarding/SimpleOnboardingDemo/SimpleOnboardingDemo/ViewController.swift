//
//  ViewController.swift
//  SimpleOnboardingDemo
//
//  Created by jrasmusson on 2021-01-08.
//

import UIKit

class ViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()

        override func viewDidLoad() {
            super.viewDidLoad()
            setup()

            dataSource = self
            delegate = self
            let initialPage = 0
            let page1 = ViewController1()
            let page2 = ViewController2()
            let page3 = ViewController3()

            // add the individual viewControllers to the pageViewController
            pages.append(page1)
            pages.append(page2)
            pages.append(page3)
            setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

            // pageControl
            pageControl.frame = CGRect()
            pageControl.currentPageIndicatorTintColor = UIColor.black
            pageControl.pageIndicatorTintColor = UIColor.lightGray
            pageControl.numberOfPages = pages.count
            pageControl.isUserInteractionEnabled = false // note
            pageControl.currentPage = initialPage
            view.addSubview(pageControl)

            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
            pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
}

extension ViewController {
    
}

extension ViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return pages.last
            } else {
                // go to previous page in array
                return pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                // go to next page in array
                return pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return pages.first
            }
        }
        return nil
    }
}

extension ViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

// MARK: - ViewControllers

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
