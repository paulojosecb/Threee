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
    
    lazy var dottedGrid: DottedGridView = {
        return DottedGridView(frame: self.view.frame)
    }()
    
    lazy var pageTitleLabelView: PageTitleLabelView = {
        let view = PageTitleLabelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(delegate: self)
        viewModel?.observerToday()
        
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(dottedGrid)
        self.view.addSubview(pageTitleLabelView)
        
        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        pageTitleLabelView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -3).isActive = true
        pageTitleLabelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 43.0).isActive = true
    }
    
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
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

