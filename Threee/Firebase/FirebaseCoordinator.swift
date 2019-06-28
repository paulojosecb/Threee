//
//  FirebaseCoordinator.swift
//  Threee
//
//  Created by Paulo José on 28/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCoordinator {
    
    static let shared = FirebaseCoordinator()
    
    let databaseReference: DatabaseReference
    let auth: Auth
    
    init() {
        self.databaseReference = Database.database().reference()
        self.auth = Auth.auth()
    }
    
}
