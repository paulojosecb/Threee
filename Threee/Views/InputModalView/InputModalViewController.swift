//
//  InputModalView.swift
//  Threee
//
//  Created by Paulo José on 09/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class InputModalViewController: ModalViewController {
    
    var delegate: InputModalViewDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
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
        textField.delegate = self
        textField.placeholder = "Type here"
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
        button.backgroundColor = UIColor.gray
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.titleLabel?.font = UIFont.title
        button.isEnabled = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDismiss(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func setupViews() {
        view.addSubview(backdropView)
        view.addSubview(cardView)
        view.addSubview(label)
        view.addSubview(input)
        view.addSubview(inputLineView)
        view.addSubview(button)
        
        let buttonTap = UITapGestureRecognizer(target: self, action: #selector(handlerButtonTap(_:)))
        button.addGestureRecognizer(buttonTap)
        
        let backdropViewTap = UITapGestureRecognizer(target: self, action: #selector(handlerBackdropTap(_:)))
        backdropView.addGestureRecognizer(backdropViewTap)

        input.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        cardView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        cardViewCenterYAnchor =  cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        cardViewCenterYAnchor?.isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 264).isActive = true
        
        label.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27).isActive = true
        label.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 27).isActive = true
        label.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -27).isActive = true
        label.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        input.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -45).isActive = true
        input.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        input.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        input.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    @objc func handlerBackdropTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
                    
            UIView.animate(withDuration: 0.2) {
                self.cardViewCenterYAnchor?.constant -= 55
                self.view.layoutIfNeeded()
            }
    }
    
    @objc func keyboardWillDismiss(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
                        
            UIView.animate(withDuration: 0.2) {
                self.cardViewCenterYAnchor?.constant = 0
                self.view.layoutIfNeeded()
            }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text != "") {
            button.backgroundColor = .yellow
            button.isEnabled = true
        } else {
            button.backgroundColor = .gray
            button.isEnabled = false
        }
    }
}

extension InputModalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (input.text != "") {
            textField.resignFirstResponder()
            handlerButtonTap(nil)
            return true
        } else {
            dismiss(animated: true, completion: nil)
            return true
        }
    }
}

extension InputModalViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPushTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPopTransition()
    }
}
