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
    func didReceivedError(error: Error)
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
    
    func signIn() {
        if (auth == nil) {
            initializeAuthUseCase()
        }
        
        guard let auth = auth else { return }
    
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
