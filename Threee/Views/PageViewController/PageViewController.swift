//
//  PageViewController.swift
//  Threee
//
//  Created by Paulo José on 19/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum PageViewMode {
    case firstTime
    case other
}

class PageViewController: UIPageViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    lazy var pages: [HomeViewController] = {
        return [
            HomeViewController(mode: .today),
            HomeViewController(mode: .tomorrow)]
    }()
    
    var mode: PageViewMode
        
    init(mode: PageViewMode) {
        self.mode = mode
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        guard let firstPage = pages.first else { return }
        
        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (mode == .firstTime) {
            mode = .other
            let vc = AlertModalViewController(mode: .welcome)
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }
                
    }
    
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let homeVC = viewController as? HomeViewController else {
            return nil
        }
        
        if (homeVC.mode == .today) {
            return nil
        } else if (homeVC.mode == .tomorrow) {
            return pages[0]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let homeVC = viewController as? HomeViewController else {
            return nil
        }
        
        if (homeVC.mode == .today) {
            return pages[1]
        } else if (homeVC.mode == .tomorrow) {
            return nil
        }
        
        return nil
    }
    
    
}
