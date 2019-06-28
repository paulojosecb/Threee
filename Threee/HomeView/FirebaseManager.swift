//
//  FirebaseManager.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    let database: DatabaseReference
    
    var authUser: User?
    
    init() {
        database = Database.database().reference()
    }
    
    func createHelloWorld(user: User) {
        self.database.child("users").childByAutoId().setValue(user.transform())
    }
    
    func getUsers() {
        self.database.child("users").child("-LiQJ5NrvuAlZAGzhiin").observeSingleEvent(of: .value) { (snapshot) in
            
            
            guard let value = snapshot.value as? NSDictionary else { return }
            
            guard let json = try? JSONSerialization.data(withJSONObject: value, options: []) else { return }
            let object = try? JSONDecoder().decode(User.self, from: json)
            
            self.authUser = object
        }
    }
    
}
