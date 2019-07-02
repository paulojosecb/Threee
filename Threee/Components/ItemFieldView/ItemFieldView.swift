//
//  ItemFieldView.swift
//  Threee
//
//  Created by Paulo José on 01/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class ItemFieldView: UIView {
    
    var item: Item? {
        didSet {
            
        }
    }
    
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
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = UIColor.init(white: 0, alpha: 0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var textFieldUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var checkedLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(label)
        addSubview(underlineView)
        addSubview(textField)
        addSubview(checkedLine)
        addSubview(textFieldUnderlineView)
        
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        
        underlineView.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        underlineView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        underlineView.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        
        textField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 16.0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        
        checkedLine.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        checkedLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        checkedLine.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
    
        textFieldUnderlineView.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        textFieldUnderlineView.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        textFieldUnderlineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        textFieldUnderlineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2.0).isActive = true
        
        addSwipeRightGesture()
        addSwipeLeftGesture()
        addTapGestureOnTextField()
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
    
    func addTapGestureOnTextField() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer? = nil) {
        textField.becomeFirstResponder()
    }
    
    func animateCheckLine() {
        
    }
    
    
    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer? = nil) {
        
        guard let sender = sender, let item = item else { return }
        
        switch sender.direction {
        case .right:
            if (!item.checked) {
                checkRightAnchor = checkedLine.rightAnchor.constraint(equalTo: textField.rightAnchor)
                checkRightAnchor?.isActive = true
                
                UIView.animate(withDuration: 0.5) {
                    self.checkRightAnchor?.constant = 0
                    self.layoutIfNeeded()
                }
                
                item.checked = !item.checked
            }
        case .left:
            if (item.checked) {
                checkRightAnchor = checkedLine.rightAnchor.constraint(equalTo: textField.rightAnchor)
                checkRightAnchor?.isActive = true
                
                UIView.animate(withDuration: 0.5) {
                    self.checkRightAnchor?.constant = -400
                    self.layoutIfNeeded()
                }
                
                item.checked = !item.checked
            }
        default:
            print("Swipe not treated")
        }
        

        
    }
    
}
