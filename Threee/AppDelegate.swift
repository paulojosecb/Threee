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
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    var authManager: FirebaseAuthManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = PageViewController(mode: .firstTime)
        
        window?.makeKeyAndVisible()
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        notificationCenter.getNotificationSettings { (setting) in
            if (setting.authorizationStatus == .notDetermined) {
                notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
                    if didAllow {
                        self.createNotification(with: notificationCenter)
                    }
                }
            } else if (setting.authorizationStatus == .authorized) {
                print("Auth")
            }
        }
        
        
        return true
    }
    
    func createNotification(with center: UNUserNotificationCenter) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "It's planning time!"
        notificationContent.body = "Open Threee and write down what you need to do tomorrow"
        notificationContent.sound = .default
        
        var date = DateComponents()
        date.hour = 20
        date.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        center.add(request) { (error) in
            if (error != nil) {
                self.createNotification(with: center)
            }
           
        }
    }

}

