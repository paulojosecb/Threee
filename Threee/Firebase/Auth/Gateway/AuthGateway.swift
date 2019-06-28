//
//  AuthGateway.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation

enum AuthResultEnum<AuthSucess, Error> {
    case success(AuthSucess)
    case failure(Error)
}

typealias AuthResult = AuthResultEnum<AuthSucess, AuthError>

protocol AuthGateway {
    func signUp(email: String, password: String, name: String, completion: @escaping ((AuthResult) -> Void))
    func signIn(email: String, password: String, completion: @escaping ((AuthResult) -> Void))
    func signOut(completion: @escaping ((AuthResult) -> Void))
}
