//
//  ViewController.swift
//  Project28
//
//  Created by Евгений Карпов on 26.01.2022.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var secret: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    title = "Nothing to see here"
    notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  @objc func doneButtonTapped() {
    navigationItem.rightBarButtonItem?.isEnabled = false
    saveSecretMessage()
  }
  
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
    
    if notification.name == UIResponder.keyboardWillHideNotification {
      secret.contentInset = .zero
    } else {
      secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }
    
    secret.scrollIndicatorInsets = secret.contentInset
    
    let selectedRange = secret.selectedRange
    secret.scrollRangeToVisible(selectedRange)
  }
  
  @IBAction func authenticateTapped(_ sender: Any) {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Identify yourself!"
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
        [weak self] success, authenticationError in
        
        DispatchQueue.main.async {
          if success {
            self?.unlockSecretMessage()
          } else {
            let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Auth with password", style: .default, handler: { [weak self ]_ in
              self?.authenticateWithPassword()
            }))
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
          }
        }
      }
    } else {
      let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      ac.addAction(UIAlertAction(title: "Auth with password", style: .default, handler: { [weak self ]_ in
        self?.authenticateWithPassword()
      }))
      self.present(ac, animated: true)
    }
  }
  
  func unlockSecretMessage() {
    secret.isHidden = false
    title = "Secret stuff!"
    navigationItem.rightBarButtonItem?.isEnabled = true
    if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
      secret.text = text
    }
  }
  
  @objc func saveSecretMessage() {
    guard secret.isHidden == false else { return }
    
    KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
    secret.resignFirstResponder()
    secret.isHidden = true
    title = "Nothing to see here"
  }
  
  func authenticateWithPassword() {
    let ac = UIAlertController(title: "Authenticate with password", message: "Enter your password", preferredStyle: .alert)
    ac.addTextField { tf in
      tf.placeholder = "Password"
      tf.isSecureTextEntry = true
    }
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
      guard let text = ac.textFields?.first?.text, text == "1234" else {
        self?.wrongPasswordAlert()
        return
      }
      self?.unlockSecretMessage()
    }))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }
  
  func wrongPasswordAlert() {
    let ac = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(ac, animated: true)
  }
}

