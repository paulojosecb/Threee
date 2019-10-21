//
//  ItemFieldView.swift
//  Threee
//
//  Created by Paulo José on 01/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

enum ItemMode {
    case today
    case tomorrow
}

class ItemFieldView: UITableViewCell {
    
    var item: Item? {
        didSet {
            guard let item = item else { return }
            itemLabel.text = item.name
            
            UIView.animate(withDuration: 0.3, animations: {
                self.checkLineConstraint?.constant = item.checked ? 250 : 0
                self.layoutIfNeeded()
            }) { (bool) in
                self.feedbackGenerator?.selectionChanged()
            }
            
        }
    }
    
    var mode: HomeViewMode?
    var tomorrowHandler: (() -> Void)?
    var editHandler: ((String) -> Void)?
    
    var checkLineConstraint: NSLayoutConstraint?
    
    var delegate: ItemFieldViewDelegate?
    var index: Int? {
        didSet {
            guard let index = index else { return }
            label.text = "Task \(index + 1)"
        }
    }
    
    var feedbackGenerator: UISelectionFeedbackGenerator? = nil
    
    static var reuseIdentifier = "ItemFieldView"
    static let height: CGFloat = 71.0
    static let gapBetweenItems: CGFloat = 45.0
    
    var checkWidthAnchor: NSLayoutConstraint?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.label18
        label.textColor = UIColor.black
        label.text = "Task: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var underlineView: UnderlineView = {
        let view = UnderlineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var itemLabel: UILabel = {
        let textField = UILabel()
        textField.isUserInteractionEnabled = true
        textField.font = UIFont.regular20
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor.init(white: 0, alpha: 0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var editButton: UIButton = {
       let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .label18
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editHandler(_:))))
        return button
    }()
    
    lazy var checkedLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        print(self.label)
    }
    
    func setupViews() {
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        addSubview(label)
        addSubview(underlineView)
        addSubview(itemLabel)
        addSubview(checkedLine)
        addSubview(editButton)
        
        label.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        
        underlineView.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        underlineView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        underlineView.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        
        itemLabel.leftAnchor.constraint(equalTo: underlineView.leftAnchor, constant: 8.0).isActive = true
        itemLabel.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        itemLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 16.0).isActive = true
        itemLabel.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        
        checkedLine.centerYAnchor.constraint(equalTo: itemLabel.centerYAnchor).isActive = true
        checkedLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        checkedLine.leftAnchor.constraint(equalTo: itemLabel.leftAnchor).isActive = true
        
        editButton.centerYAnchor.constraint(equalTo: checkedLine.centerYAnchor).isActive = true
        editButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: editButton.intrinsicContentSize.width).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: editButton.intrinsicContentSize.height).isActive = true
        
        checkLineConstraint = checkedLine.widthAnchor.constraint(equalToConstant: 0)
        checkLineConstraint?.isActive = true
        
        addTapGesture()
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapHandler(_ sender: UISwipeGestureRecognizer? = nil) {
        guard let index = index, let delegate = self.delegate, let mode = mode,
            let tomorrowHandler = tomorrowHandler,
            let editHandler = editHandler else { return }
        
        if (mode == .today) {
            delegate.toggleItem(on: index)
        } else if (mode == .edit) {
            guard let name = item?.name else { return }
            editHandler(name)
        } else {
            tomorrowHandler()
        }
        
    }
    
    @objc func editHandler(_ sender: UISwipeGestureRecognizer? = nil) {
        guard let delegate = self.delegate, let editHandler = editHandler, let name = item?.name else { return }
        editHandler(name)
    }
    
}
