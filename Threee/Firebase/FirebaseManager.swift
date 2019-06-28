//
//  FirebaseManager.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let database: DatabaseReference
    
    var user: User? {
        didSet {
            print(self.user)
        }
    }
    
    init() {
        Database.database().isPersistenceEnabled = true
        database = Database.database().reference()
    }
    
    func create(user: User, with uid: String) {
        self.database.child("users").child(uid).setValue(user.transform())
    }
    
    func setUser(by uid: String) {
        
        self.database.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else { return }
            
            
            do {
                let json = try JSONSerialization.data(withJSONObject: value, options: [])
                let object = try JSONDecoder().decode(User.self, from: json)
                self.user = object
            } catch let error {
                print(error)
            }
        
        }
    }
    
}
