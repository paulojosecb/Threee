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
                self.checkLineConstraint?.constant = item.checked ? 300 : 0
                self.layoutIfNeeded()
            }) { (bool) in
                self.feedbackGenerator?.selectionChanged()
            }
            
        }
    }
    
    var mode: ItemMode?
    var tomorrowHandler: (() -> Void)?
    
    var checkLineConstraint: NSLayoutConstraint?
    
    var delegate: ItemFieldViewDelegate?
    var index: Int? {
        didSet {
            guard let index = index else { return }
            label.text = "Thing \(index + 1)"
        }
    }
    
    var feedbackGenerator: UISelectionFeedbackGenerator? = nil
    
    static var reuseIdentifier = "ItemFieldView"
    static let height: CGFloat = 71.0
    static let gapBetweenItems: CGFloat = 75.0
    
    var checkWidthAnchor: NSLayoutConstraint?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.label18
        label.textColor = UIColor.black
        label.text = "Thing: 0"
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
            let tomorrowHandler = tomorrowHandler else { return }
        
        if (mode == .today) {
            delegate.toggleItem(on: index)
        } else {
            tomorrowHandler()
        }
        
    }
    
}
