//
//  LocaNotificationScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 15/05/25.
//

import SwiftUI
import UserNotifications

struct LocaNotificationScreen: View {
    var body: some View {
      VStack(spacing: 20) {
        Group {
          Button("Request Authorization") {
            NotificationManager.shared.requestNotificationAuthorization()
          }
          
          Button("Send Notification") {
            NotificationManager.shared.sendNotification()
          }
          
          Button("Cancel Notification") {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
          }
        }
        .buttonStyle(.borderedProminent)
      }
      .onAppear {
        UNUserNotificationCenter.current().setBadgeCount(0)
      }
    }
}

final class NotificationManager {
  static let shared = NotificationManager()
  
  private init() {}
  
  func requestNotificationAuthorization() {
    let options: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
      guard error == nil else {
        print("Failed to request notification authorization: \(error!)")
        return
      }
      
      print("requestNotificationAuthorization granted: \(granted)")
    }
  }
  
  func sendNotification() {
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "Notification Title"
    notificationContent.body = "Notification Body"
    notificationContent.sound = .default
    notificationContent.badge = 2
    
    // Time
    let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
    
    let notificationRequest = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: notificationContent,
      trigger: notificationTrigger)
    
    UNUserNotificationCenter.current().add(notificationRequest)
  }
}

#Preview {
    LocaNotificationScreen()
}
