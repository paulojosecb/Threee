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
    var auth: AuthUseCase?
    
    init(delegate: SignUpViewModelDelegate) {
        self.delegate = delegate
    }
    
    func initializeAuthUseCase() {
        let gateway = AuthGatewayFirebase(auth: FirebaseCoordinator.shared.auth)
        auth = AuthUseCase(gateway: gateway, presenter: self)
    }
    
    func signUp(email: String, password: String) {
        if auth == nil {
            initializeAuthUseCase()
        }
        
        guard let auth = auth else { return }
        
        auth.signUp(email: email, password: password, name: "")
    }
    
}

extension SignUpViewModel: AuthPresenter {
    func sucess(_ sucess: AuthSucess) {
        delegate.didSignedUp()
    }
    
    func failure(_ error: AuthError) {
        delegate.didReceived(error: error)
    }
    
    
}
