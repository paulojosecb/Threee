//
//  ViewController.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        viewModel = HomeViewModel(delegate: self)
        
        viewModel?.observerToday()
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdate(day: Day) {
        print(day)
    }
    
    func didReceivedError(error: Error) {
        print(error)
    }
    
    
}

