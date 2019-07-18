//
//  AuthUseCase.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

class AuthUseCase {
    private let gateway: AuthGateway
    private let presenter: AuthPresenter
    
    init(gateway: AuthGateway, presenter: AuthPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }
    
    func signUp(email: String, password: String, name: String) {
        gateway.signUp(email: email, password: password, name: name, completion: presentResult(result:))
    }
    
    func signIn(email: String, password: String) {
        gateway.signIn(email: email, password: password, completion: presentResult(result:))
    }
    
    private func presentResult(result: AuthResult) {
        switch result {
        case let .success(authSucess): self.presenter.sucess(authSucess)
        case let .failure(error): self.presenter.failure(error)
        }
    }
    
}
