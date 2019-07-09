//
//  ItemFieldView.swift
//  Threee
//
//  Created by Paulo José on 01/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class ItemFieldView: UITableViewCell {
    
    var item: Item? {
        didSet {
            guard let item = item else { return }
            itemLabel.text = item.name
        }
    }
    
    var feedbackGenerator: UISelectionFeedbackGenerator? = nil
    
    static var reuseIdentifier = "ItemFieldView"
    static let height: CGFloat = 71.0
    static let gapBetweenItems: CGFloat = 75.0
    
    var checkRightAnchor: NSLayoutConstraint?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.label
        label.textColor = UIColor.black
        label.text = "Thing 1:"
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
        textField.font = UIFont.regular
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
        checkedLine.widthAnchor.constraint(equalToConstant: 0).isActive = true
        
        addSwipeRightGesture()
        addSwipeLeftGesture()
    }
    
    func addSwipeRightGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }
    
    func addSwipeLeftGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
        swipeGesture.direction = .left
        self.addGestureRecognizer(swipeGesture)
    }
    
    func animateCheckLine() {
        
    }
    
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer? = nil) {
        
        guard let sender = sender, let item = item else { return }
        
        feedbackGenerator = UISelectionFeedbackGenerator()
        
        switch sender.direction {
        case .right:
            if (!item.checked) {
                checkRightAnchor = checkedLine.rightAnchor.constraint(equalTo: itemLabel.rightAnchor)
                checkRightAnchor?.isActive = true
                
                UIView.animate(withDuration: 0.5) {
                    self.checkRightAnchor?.constant = 0
                    self.layoutIfNeeded()
                }
                
                feedbackGenerator?.selectionChanged()
                
                item.checked = !item.checked
            }
        case .left:
            if (item.checked) {
                checkRightAnchor = checkedLine.rightAnchor.constraint(equalTo: itemLabel.rightAnchor)
                checkRightAnchor?.isActive = true
                
                UIView.animate(withDuration: 0.5) {
                    self.checkRightAnchor?.constant = -400
                    self.layoutIfNeeded()
                }
                
                feedbackGenerator?.selectionChanged()

                
                item.checked = !item.checked
            }
        default:
            print("Swipe not treated")
        }
        

        
    }
    
}
