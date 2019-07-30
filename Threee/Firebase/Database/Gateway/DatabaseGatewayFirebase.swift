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
            guard let value = snapshot.value as? NSDictionary else {
//                completion(DayObserverResult.failure(Error( )
                return
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: value, options: [])
                let user = try JSONDecoder().decode(User.self, from: json)
                completion(FetchResult.success(user))
            } catch let error {
                completion(FetchResult.failure(error))
            }
        }
    }
    
    func observerDay(with uid: String, completion: @escaping (DayObserverResult) -> Void) {
        
        guard let userUid = FirebaseCoordinator.shared.auth.currentUser?.uid else { return }
        
        self.database.child("users").child(userUid).child("days").child(uid).observe(.value) { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else { return }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: value, options: [])
                let day = try JSONDecoder().decode(Day.self, from: json)
                completion(DayObserverResult.sucess(day))
            } catch let error {
                completion(DayObserverResult.failure(error))
            }
        }
    }
    
    func update(day: Day, with uid: String) {
        guard let userUid = FirebaseCoordinator.shared.auth.currentUser?.uid else { return }
        self.database.child("users").child(userUid).child("days").child(uid).updateChildValues(day.transform())
    }
    
    func update(user: User, with uid: String, completion: @escaping (UserUpdateResult) -> Void) {
        
        self.database.child("users").child(uid).updateChildValues(user.transform()) { (error, reference) in
            if (error != nil) {
                completion(UserUpdateResult.failure(error!))
            } else {
                completion(UserUpdateResult.sucess(User(name: "")))
            }
        }
        
    }
    
    
}
