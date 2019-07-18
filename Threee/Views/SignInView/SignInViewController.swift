//
//  SignInViewController.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var viewModel: SignInViewModel?
    
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
        view.descriptor = "Password:"
        return view
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .title
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    override func viewDidLayoutSubviews() {
        dottedGrid.drawDots()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignInViewModel(delegate: self)
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSignIn(_:)))
        signInButton.addGestureRecognizer(tapGesture)
        
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

        // Do any additional setup after loading the view.
    }
    
    
    func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(dottedGrid)
        view.addSubview(welcomeImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(backdropView)
        view.addSubview(activity)
        
        dottedGrid.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        dottedGrid.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        dottedGrid.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        dottedGrid.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        welcomeImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 43).isActive = true
        welcomeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        welcomeImage.heightAnchor.constraint(equalToConstant: 66).isActive = true
        welcomeImage.widthAnchor.constraint(equalToConstant: 224).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 30).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        signInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
    
    @objc func didTapSignIn(_ sender: UITapGestureRecognizer? = nil) {
        guard let viewModel = viewModel else { return }
        setLoadingState()
        viewModel.signIn(email: "", password: "")
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            guard let window = UIApplication.shared.keyWindow else { return }
            
            UIView.animate(withDuration: 0.2) {
                self.view.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -keyboardHeight).isActive = true
            }
        }
    }
    
    @objc func keyboardWillDismiss(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            guard let window = UIApplication.shared.keyWindow else { return }
            
            UIView.animate(withDuration: 0.2) {
                self.view.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            }
        }
    }

}

extension SignInViewController: SignInViewModelDelegate {
    func didSignedIn() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: true, completion: nil)
    }
    
    func didReceivedError(error: Error) {
        setFailedState()
    }
    
    
}
