//
//  ViewController.swift
//  Project21
//
//  Created by Евгений Карпов on 06.01.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Register",
      style: .plain,
      target: self,
      action: #selector(registerLocal))
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Schedule",
      style: .plain,
      target: self,
      action: #selector(scheduleLocal))
  }
  
  // MARK: - Module functions
  
  /// Register local permission
  @objc private func registerLocal() {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
      if granted {
        print("Yay!")
      } else {
        print("D'oh")
      }
    }
  }
  
  @objc private func scheduleLocal() {
    registerCategories()
    
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.weekday = 8
    dateComponents.hour = 10
    dateComponents.minute = 30
    //    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
  }
  
  
  ///Register notification categories
  private func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    
    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let remindMeLater = UNNotificationAction(identifier: "remindMeLater", title: "Remind me later", options: .destructive)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show, remindMeLater], intentIdentifiers: [])
    
    center.setNotificationCategories([category])
  }
  
  // MARK: - Public functions
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo
    
    if let customData = userInfo["customData"] as? String {
      print("Custom data received: \(customData)")
      
      switch response.actionIdentifier {
      case UNNotificationDefaultActionIdentifier:
        // the user swiped to unlock
        print("Default identifier")
        let ac = UIAlertController(title: "Default", message: "Default identifier", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
      case "show":
        // the user tapped our "show more info…" button
        print("Show more information…")
        let ac = UIAlertController(title: "SHOW", message: "Show more information…?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
      case "remindMeLater":
        scheduleLocal()
      default:
        break
      }
    }
    
    // you must call the completion handler when you're done
    completionHandler()
  }
  
}

