//
//  SignInViewModel.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.


import Foundation

protocol SignInViewModelDelegate {
    func didSignedIn()
    func didReceivedError(error: Error)
}

class SignInViewModel {

    var delegate: SignInViewModelDelegate

    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }

    func initializeAuthUseCase() {

    }

    func signIn(email: String, password: String) {

    }

}

