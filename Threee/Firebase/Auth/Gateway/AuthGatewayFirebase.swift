//
//  FirebaseAuthMananger.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthGatewayFirebase: AuthGateway {
    
    let auth: Auth
    
    init(auth: Auth) {
        self.auth = auth
    }
    
    
    func signUp(email: String, password: String, name: String, completion: @escaping ((AuthResult) -> Void)) {
        auth.createUser(withEmail: email, password: password) { (dataResult, error) in

            if let error = error {
                let authError = AuthResult.failure(AuthError(rawValue: error._code))
                completion(authError)
                return
            }
             
            guard let user = dataResult?.user else { return }
    
            self.saveUserData(user: User(name: name), uid: user.uid, completion: completion)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping ((AuthResult) -> Void)) {
        auth.signIn(withEmail: email, password: password) { (dataResult, error) in
           
            if let error = error {
                let authError = AuthResult.failure(AuthError(rawValue: error._code))
                completion(authError)
                return
            }
            
            completion(AuthResult.success(AuthSucess.signedIn))
        }
    }
    
    func signOut(completion: @escaping ((AuthResult) -> Void)) {
        
        do {
            try auth.signOut()
        } catch let error {
            let authError = AuthResult.failure(AuthError(rawValue: error._code))
            completion(authError)
        }
        
       completion(AuthResult.success(AuthSucess.signedOut))
    }
    
    private func saveUserData(user: User, uid: String, completion: @escaping ((AuthResult) -> Void)) {
        Database.database().reference().child("users").child(uid).updateChildValues(user.transform()) { (error, reference) in
            if let _ = error {
                self.saveUserData(user: user, uid: uid, completion: completion)
                return
            }
            
            completion(AuthResult.success(.registered))
        }
    }
    
}
