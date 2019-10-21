//
//  ViewController.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum HomeViewMode {
    case today
    case tomorrow
    case edit
}

class HomeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    var viewModel: HomeViewModel?
    var mode: HomeViewMode {
        didSet {
//            editButton.setTitle(self.mode == .edit ? "Save" : "Edit", for: .normal)
            tableView.reloadData()
        }
    }
    let initialMode: HomeViewMode
    
    lazy var dottedGrid: DottedGridView = {
        return DottedGridView(frame: self.view.frame)
    }()
    
    lazy var letteringImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LetsImage") ?? UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()

    lazy var pageTitleLabelView: PageTitleLabelView = {
        let view = PageTitleLabelView()
        view.titleLabel.text = mode == .today ? "Today" : "Tomorrow"
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
    
//    lazy var editButton: UIButton = {
//        let button = UIButton()
//        button.setTitle(self.mode == .edit ? "Save" : "Edit", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleModeGesture(_:))))
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = .action
//        return button
//    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.title
        button.backgroundColor = UIColor.yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    lazy var swipeLeft: UILabel = {
        let label = UILabel()
        label.font = .label14
        label.textColor = .systemGray
        label.text = "Swipe Left to plan tomorrow"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = self.mode == .tomorrow ? true : false
        return label
    }()
    
    lazy var swipeRight: UILabel = {
        let label = UILabel()
        label.font = .label14
        label.textColor = .systemGray
        label.text = "Swipe Right to plan today"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = self.mode == .tomorrow ? false : true
        return label
    }()
    
    init(mode: HomeViewMode) {
        self.mode = mode
        self.initialMode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(delegate: self, mode: self.mode == .today ? .today : .tomorrow)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAddGesture(_:)))
        addButton.addGestureRecognizer(tapGesture)
                
        setupViews()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        
        guard let viewModel = viewModel,
            let day = viewModel.day,
            let items = day.items else { return }
        
        if (items.count >= 3) {
            addButton.isHidden = true
        }
        
        if (mode == .tomorrow && items.count < 3 ) {
            
            presentAlert(with: .planning)
            
        }
    }
    
    func setupViews() {
        self.view.addSubview(dottedGrid)
        self.view.addSubview(letteringImageView)
        self.view.addSubview(pageTitleLabelView)
//        self.view.addSubview(editButton)
        self.view.addSubview(tableView)
        self.view.addSubview(addButton)
        self.view.addSubview(swipeLeft)
        self.view.addSubview(swipeRight)
          
        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                
        letteringImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56).isActive = true
        letteringImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        letteringImageView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 0).isActive = true
        letteringImageView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: 0).isActive = true
        letteringImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pageTitleLabelView.topAnchor.constraint(equalTo: letteringImageView.bottomAnchor, constant: 32).isActive = true
        pageTitleLabelView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -2).isActive = true
        
//        editButton.topAnchor.constraint(equalTo: letteringImageView.bottomAnchor, constant: 32).isActive = true
//        editButton.centerYAnchor.constraint(equalTo: pageTitleLabelView.centerYAnchor).isActive = true
//        editButton.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: pageTitleLabelView.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        swipeLeft.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        swipeLeft.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16).isActive = true
        swipeLeft.heightAnchor.constraint(equalToConstant: swipeLeft.intrinsicContentSize.height).isActive = true
        
        swipeRight.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        swipeRight.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16).isActive = true
        swipeRight.heightAnchor.constraint(equalToConstant: swipeLeft.intrinsicContentSize.height).isActive = true
        
        addButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
    }
    
    @objc func handleAddGesture(_ sender: UITapGestureRecognizer? = nil) {
        let vc = InputModalViewController(mode: .creating)
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = viewModel
        present(vc, animated: true, completion: nil)
    }
        
    @objc func handleModeGesture(_ sender: UITapGestureRecognizer? = nil) {
        self.mode = self.mode != .edit ? .edit : self.initialMode
        
        guard let count = viewModel?.day?.items?.count else { return }
        
        if (self.mode == .edit) {
            letteringImageView.image = UIImage(named: "EditImage") ?? UIImage()
        } else if (count < 3) {
            letteringImageView.image = UIImage(named: "LetsImage") ?? UIImage()
        } else {
            letteringImageView.image = UIImage(named: "CheckImage") ?? UIImage()
        }
    }
    
    func presentAlert(with mode: AlertMode) {
        let vc = AlertModalViewController(mode: mode)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didUpdate(day: Day) {
        guard let items = day.items else {
            return
        }
        
        items.count >= 3 ? (addButton.isHidden = true) : (addButton.isHidden = false)
        
        if (day.isDayCompleted()) {
            presentAlert(with: .confirmation)
        }
        
        tableView.reloadData()
    }
    
    func didReceivedError(error: Error) {
       presentAlert(with: .warning)
    }
    
    func didSignedOut() {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = viewModel?.day?.items else { return 0 }
        return items.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mod = indexPath.row % 2
        
        if (mod == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemFieldView.reuseIdentifier, for: indexPath) as? ItemFieldView else { return UITableViewCell()}
            
            guard let items = viewModel?.day?.items else { return UITableViewCell() }
        
            cell.item = items[indexPath.row / 2]
            cell.delegate = viewModel
            cell.index = indexPath.row / 2
            cell.mode = self.mode
            
            cell.tomorrowHandler = { () -> Void in
                self.presentAlert(with: .isNotTypeToCheck)
            }
            
            cell.editHandler = { (currentValue: String) -> Void in
                let vc = InputModalViewController(mode: .editing, currentValue: currentValue, position: indexPath.row / 2)
                vc.modalPresentationStyle = .overCurrentContext
                vc.delegate = self.viewModel
                self.present(vc, animated: true, completion: nil)
            }
            
            return cell
        } else {
            guard let separetor = tableView.dequeueReusableCell(withIdentifier: UITableViewSeparatorCell.reuseIdentifier, for: indexPath) as? UITableViewSeparatorCell else {return UITableViewCell()}
            separetor.height = ItemFieldView.gapBetweenItems
            return separetor
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? ItemFieldView.height : ItemFieldView.gapBetweenItems
    }
        
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

