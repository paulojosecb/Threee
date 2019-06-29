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
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.titleLabel?.text = "SignUp"
        button.titleLabel?.textColor = .white
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
    
    override func viewDidLoad() {
        
        viewModel = SignUpViewModel(delegate: self)
        
        view.backgroundColor = .white
        view.addSubview(signUpButton)
        view.addSubview(backdropView)
        view.addSubview(activity)
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapSignUp(_:)))
        signUpButton.addGestureRecognizer(tapGesture)
    }
    
    func setupViews() {
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        backdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backdropView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backdropView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func didTapSignUp(_ sender: UITapGestureRecognizer? = nil) {
        setLoadingState()
        
        guard let viewModel = viewModel else { return }
        
        viewModel.signUp()
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
    
}

extension SignUpViewController: SignUpViewModelDelegate {
    func didSignedUp() {
        let vc = HomeViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func didReceived(error: Error) {
        setFailedState()
    }
    
    
}
