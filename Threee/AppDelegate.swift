//
//  AppDelegate.swift
//  Threee
//
//  Created by Paulo José on 27/06/19.
//  Copyright © 2019 Paulo José. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    var authManager: FirebaseAuthManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        if let _ = FirebaseCoordinator.shared.auth.currentUser {
            window?.rootViewController = HomeViewController()
//        } else {
//            window?.rootViewController = SignUpViewController()
//        }
        
        window?.makeKeyAndVisible()
        
//        authManager = FirebaseAuthManager.shared
        
        
        return true
    }

}

