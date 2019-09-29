//
//  SignUpViewController.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var viewModel: SignUpViewModel?
    
    var welcomeTopAnchor: NSLayoutConstraint?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    lazy var dottedGrid: DottedGridView = {
        let view = DottedGridView(frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcome")
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var emailTextField: CustomTextFieldView = {
        let view = CustomTextFieldView(frame: .zero, descriptor: "Email:")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.descriptor = "Email:"
        return view
    }()
    
    lazy var passwordTextField: CustomTextFieldView = {
        let view = CustomTextFieldView(frame: .zero, descriptor: "Password:")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.isSecureTextEntry = true
        view.descriptor = "Password:"
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextFieldView = {
        let view = CustomTextFieldView(frame: .zero, descriptor: "Confirm Password:")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .title
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var goToSignUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.textColor = UIColor.black
        label.font = .regular18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var signUpHereLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in here"
        label.textColor = .black
        label.font = .label18
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.stopAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        
        viewModel = SignUpViewModel(delegate: self)
    
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSignUp(_:)))
        signUpButton.addGestureRecognizer(tapGesture)
        
        let signInTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSignInHere(_:)))
        signUpHereLabel.isUserInteractionEnabled = true
        signUpHereLabel.addGestureRecognizer(signInTapGesture)
        
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
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
    }
    
    func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(dottedGrid)
        view.addSubview(welcomeImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(signUpButton)
        view.addSubview(goToSignUpLabel)
        view.addSubview(signUpHereLabel)
        view.addSubview(backdropView)
        view.addSubview(activity)
        
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        welcomeTopAnchor = welcomeImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 43)
        welcomeTopAnchor?.isActive = true
        welcomeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        welcomeImage.heightAnchor.constraint(equalToConstant: 66).isActive = true
        welcomeImage.widthAnchor.constraint(equalToConstant: 224).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 30).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: CustomTextFieldView.height).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: CustomTextFieldView.height).isActive = true
        
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
        confirmPasswordTextField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        confirmPasswordTextField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: CustomTextFieldView.height).isActive = true
        
        signUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        goToSignUpLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -23).isActive = true
        goToSignUpLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        goToSignUpLabel.widthAnchor.constraint(equalToConstant: goToSignUpLabel.intrinsicContentSize.width).isActive = true
        
        signUpHereLabel.topAnchor.constraint(equalTo: goToSignUpLabel.topAnchor).isActive = true
        signUpHereLabel.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        signUpHereLabel.widthAnchor.constraint(equalToConstant: signUpHereLabel.intrinsicContentSize.width).isActive = true
        
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func didTapSignUp(_ sender: UITapGestureRecognizer? = nil) {
        setLoadingState()
        
        guard let viewModel = viewModel,
            let email = emailTextField.textField.text,
            let password = passwordTextField.textField.text else { return }
        
        
        viewModel.signUp(email: email, password: password)
    }
    
    func setLoadingState() {
        backdropView.isHidden = false
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func setFailedState() {
        backdropView.isHidden = true
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    @objc func didTapSignInHere(_ sender: UITapGestureRecognizer? = nil) {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            guard let window = UIApplication.shared.keyWindow else { return }
        
            UIView.animate(withDuration: 0.2) {
                self.welcomeTopAnchor?.constant = -35
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillDismiss(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            guard let window = UIApplication.shared.keyWindow else { return }
            
            UIView.animate(withDuration: 0.2) {
                self.welcomeTopAnchor?.constant = 43
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

extension SignUpViewController: SignUpViewModelDelegate {
    func didSignedUp() {
        let vc = PageViewController(mode: .firstTime)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func didReceived(error: Error) {
        setFailedState()
        let vc = AlertModalViewController(mode: .warning, customText: error.localizedDescription)
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    
}
