//
//  NotificationManager.swift
//  TimeCrumbs
//
//  Created by Austin Goetz on 12/10/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
    
    static func requestPermission(completionHandler: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("We have permission to send notifications")
            } else if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                // Tell them that we can't send notifications
            }
            completionHandler(granted)
        }
    }
    
    static func fireCheckInNotification(timeInterval: Int) {
        let noteContent = UNMutableNotificationContent()
        noteContent.title = "Still Working?"
        noteContent.body = "Don't forget to stop your timer if you have completed your task!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: true)
        let requestIdentifier = UUID().uuidString
        let noteRequest = UNNotificationRequest(identifier: requestIdentifier, content: noteContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(noteRequest) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    static func fireResumeTimerNotification(timeInterval: Int) {
        let noteContent = UNMutableNotificationContent()
        noteContent.title = "Back At It?"
        noteContent.body = "Don't forget to resume your timer if you started working again!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: true)
        let requestIdentifier = UUID().uuidString
        let noteRequest = UNNotificationRequest(identifier: requestIdentifier, content: noteContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(noteRequest) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    static func deletePendingNotifications() {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
}
