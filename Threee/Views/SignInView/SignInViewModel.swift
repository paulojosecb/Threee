//
//  SignInViewModel.swift
//  Threee
//
//  Created by Paulo José on 18/07/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

protocol SignInViewModelDelegate {
    func didSignedIn()
    func didReceivedError(error: AuthError)
}

class SignInViewModel {
    
    var delegate: SignInViewModelDelegate
    var auth: AuthUseCase?
    
    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }
    
    func initializeAuthUseCase() {
        let gateway = AuthGatewayFirebase(auth: FirebaseCoordinator.shared.auth)
        auth = AuthUseCase(gateway: gateway, presenter: self)
    }
    
    func signIn(email: String, password: String) {
        if (auth == nil) {
            initializeAuthUseCase()
        }
        
        guard let auth = auth else { return }
        
        auth.signIn(email: email, password: password)
    }
    
}

extension SignInViewModel: AuthPresenter {
    func sucess(_ sucess: AuthSucess) {
        delegate.didSignedIn()
    }
    
    func failure(_ error: AuthError) {
        delegate.didReceivedError(error: error)
    }
    
    
}
