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

class AuthManagerFirebase {
    
    let presenter: AuthPresenter
    
    
    init(presenter: AuthPresenter) {
        self.presenter = presenter
    }
    
    
    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (dataResult, error) in

            if let error = error {
                let authError = AuthError(rawValue: error._code)
                self.presenter.failure(error: authError)
                return
            }
             
            guard let user = dataResult?.user else { return }
    
            self.saveUserData(user: User(name: name), uid: user.uid)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
           
            if let error = error {
                let authError = AuthError(rawValue: error._code)
                self.presenter.failure(error: authError)
                return
            }
            
            self.presenter.sucess(.signedIn)
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            let authError = AuthError(rawValue: error._code)
            self.presenter.failure(error: authError)
        }
        
        self.presenter.sucess(.signedOut)
    }
    
    func saveUserData(user: User, uid: String) {
        Database.database().reference().child("users").child(uid).updateChildValues(user.transform()) { (error, reference) in
            if let _ = error {
                self.saveUserData(user: user, uid: uid)
                return
            }
            
            self.presenter.sucess(.registered)
        }
    }
    
}
