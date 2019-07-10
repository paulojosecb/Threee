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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(ItemFieldView.self, forCellReuseIdentifier: ItemFieldView.reuseIdentifier)
        tableView.register(UITableViewSeparatorCell.self, forCellReuseIdentifier:UITableViewSeparatorCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.init(white: 0, alpha: 0)
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.textColor = UIColor.black
        button.titleLabel?.font = UIFont.title
        button.backgroundColor = UIColor.yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(delegate: self)
        viewModel?.observerToday()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAddGesture(_:)))
        addButton.addGestureRecognizer(tapGesture)
        
        setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(dottedGrid)
        self.view.addSubview(pageTitleLabelView)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)

        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        pageTitleLabelView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -3).isActive = true
        pageTitleLabelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 43.0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: pageTitleLabelView.bottomAnchor, constant: 50).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        addButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
    }
    
    @objc func handleAddGesture(_ sender: UITapGestureRecognizer? = nil) {
        let vc = InputModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = viewModel
        present(vc, animated: true, completion: nil)
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdate(day: Day) {
        guard let items = day.items else {
            return
        }
        
        items.count < 3 ? (addButton.isHidden = false) : (addButton.isHidden = true)
        tableView.reloadData()
    }
    
    func didReceivedError(error: Error) {
        print(error)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = viewModel?.today?.items else { return 0 }
        return items.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mod = indexPath.row % 2
        
        if (mod == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemFieldView.reuseIdentifier, for: indexPath) as? ItemFieldView else { return UITableViewCell()}
            
            guard let items = viewModel?.today?.items else { return UITableViewCell() }
        
            cell.item = items[indexPath.row / 2]
            cell.delegate = viewModel
            cell.index = indexPath.row / 2
            
            return cell
        } else {
            guard let separetor = tableView.dequeueReusableCell(withIdentifier: UITableViewSeparatorCell.reuseIdentifier, for: indexPath) as? UITableViewSeparatorCell else {return UITableViewCell()}
            separetor.height = ItemFieldView.gapBetweenItems
            return separetor
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemFieldView.height
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

