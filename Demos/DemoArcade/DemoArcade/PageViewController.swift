//
//  PageViewController.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        let initialPage = 0
        let page1 = PageViewController1()
        let page2 = PageViewController2()
        
        // add the individual viewControllers to the pageViewController
        pages.append(page1)
        pages.append(page2)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

        // pageControl
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        view.addSubview(pageControl)

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 3).isActive = true
        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

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

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

class PageViewController1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class PageViewController2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
    }
}
