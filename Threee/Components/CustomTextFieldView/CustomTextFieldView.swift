//
//  CustomTextFieldView.swift
//  Threee
//
//  Created by Paulo José on 12/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class CustomTextFieldView: UIView {
    
    var descriptor: String {
        didSet {
            label.text = descriptor
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.label18
        label.text = self.descriptor
        return label
    }()
    
    lazy var underlineView: UnderlineView = {
        let view = UnderlineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.init(white: 0, alpha: 0)
        return textField
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()

    init(frame: CGRect, descriptor: String) {
        self.descriptor = descriptor
        super.init(frame: .zero)
        setupViews()
    }
    
//    convenience init(frame: CGRect, descriptor: String) {
//        self.init(frame: frame)
//        self.descriptor = descriptor
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(label)
        addSubview(underlineView)
        addSubview(textField)
        addSubview(line)
        
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height).isActive = true
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        
        underlineView.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        underlineView.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        underlineView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        textField.leftAnchor.constraint(equalTo: underlineView.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        line.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        line.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
