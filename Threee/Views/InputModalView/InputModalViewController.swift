//
//  InputModalView.swift
//  Threee
//
//  Created by Paulo José on 09/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class InputModalViewController: UIViewController {
    
    var delegate: InputModalViewDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    lazy var backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "What is the new most important thing for this day?"
        label.numberOfLines = 2
        label.font = UIFont.label16
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var input: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.init(white: 0, alpha: 0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var inputLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = UIFont.title
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(backdropView)
        view.addSubview(cardView)
        view.addSubview(label)
        view.addSubview(input)
        view.addSubview(inputLineView)
        view.addSubview(button)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlerButtonTap(_:)))
        button.addGestureRecognizer(tapGesture)
//        backdropView.addGestureRecognizer(tapGesture)
        
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cardView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 264).isActive = true
        
        label.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27).isActive = true
        label.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 27).isActive = true
        label.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -27).isActive = true
        label.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        input.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -45).isActive = true
        input.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        input.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        
        inputLineView.topAnchor.constraint(equalTo: input.bottomAnchor).isActive = true
        inputLineView.leftAnchor.constraint(equalTo: input.leftAnchor).isActive = true
        inputLineView.rightAnchor.constraint(equalTo: input.rightAnchor).isActive = true
        inputLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        button.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 164).isActive = true
        button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16).isActive = true
    }
    
    @objc func handlerButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let delegate = delegate, let text = input.text else { return }
        delegate.createItemWith(name: text)
        dismiss(animated: true, completion: nil)
    }
}
