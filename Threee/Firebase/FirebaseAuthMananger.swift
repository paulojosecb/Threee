//
//  FirebaseAuthMananger.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    let stateListener: AuthStateDidChangeListenerHandle
    
    
    init() {
        stateListener = Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user else { return }
            FirebaseManager.shared.setUser(by: user.uid)
        }
        
        print(Auth.auth().currentUser?.uid)
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(stateListener)
    }
    
    func createUser(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (dataResult, error) in

            print(error?.localizedDescription ?? "")
            
            guard let user = dataResult?.user else { return }
            
            let newUser = User(name: name)
            FirebaseManager.shared.create(user: newUser, with: user.uid)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
