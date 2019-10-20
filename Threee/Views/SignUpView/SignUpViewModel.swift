//
//  SignUpViewModel.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol SignUpViewModelDelegate {
    func didSignedUp()
    func didReceived(error: Error)
}

class SignUpViewModel {
    
    let delegate: SignUpViewModelDelegate
    
    init(delegate: SignUpViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signUp(email: String, password: String) {

    }
    
}

