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

class DatabaseGatewayFirebase: DatabaseGateway {

    let database: DatabaseReference
    
    init(database: DatabaseReference) {
        self.database = database
    }
    
    func fetchUser(uid: String, completion: @escaping (FetchResult) -> Void) {
        self.database.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else { return }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: value, options: [])
                let user = try JSONDecoder().decode(User.self, from: json)
                completion(FetchResult.success(user))
            } catch let error {
                completion(FetchResult.failure(error))
            }
        }
    }
    
    
}
