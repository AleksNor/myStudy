//
//  ViewController.swift
//  Project25
//
//  Created by Евгений Карпов on 17.01.2022.
//

import UIKit
import MultipeerConnectivity

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
  
  // MARK: - Properties
  var images = [UIImage]()
  var peerID = MCPeerID(displayName: UIDevice.current.name)
  var mcSession: MCSession?
  var mcAdvertiserAssistant: MCAdvertiserAssistant?
  
  // MARK: - Lifecycycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Selfie Share"
    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
    let mailButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(sendMyName))
    navigationItem.rightBarButtonItems = [cameraButton, mailButton]
    
    let connectionPrompt = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
    let connectionInfo = UIBarButtonItem(image: UIImage(systemName: "info.circle") ?? UIImage(), style: .plain, target: self, action: #selector(showInfo))
    navigationItem.leftBarButtonItems = [connectionPrompt, connectionInfo]
    
    mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
    mcSession?.delegate = self
  }
  
  // MARK: - Private functions
  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  @objc func showInfo() {
    var resultString = "1. \(peerID.displayName)"
    var counter = 2
    guard let mcSession = mcSession, !mcSession.connectedPeers.isEmpty else {
      let ac = UIAlertController(title: "Current Users", message: "Is somebody here?", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
      return
    }
    mcSession.connectedPeers.forEach { peer in
      resultString.append("\n\(counter). \(peer.displayName)")
      counter += 1
    }
    let ac = UIAlertController(title: "Current Users", message: resultString, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  
  
  @objc func showConnectionPrompt() {
    let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
    ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }
  
  func startHosting(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "hws-project25", discoveryInfo: nil, session: mcSession)
    mcAdvertiserAssistant?.start()
  }
  
  func joinSession(action: UIAlertAction) {
    guard let mcSession = mcSession else { return }
    let mcBrowser = MCBrowserViewController(serviceType: "hws-project25", session: mcSession)
    mcBrowser.delegate = self
    present(mcBrowser, animated: true)
  }
  
  @objc func sendMyName() {
    let myName = "Hi! I'm \(peerID.displayName)"
    guard let mcSession = mcSession else { return }
    if mcSession.connectedPeers.count > 0 {
      let stringData = Data(myName.utf8)
      do {
        try mcSession.send(stringData, toPeers: mcSession.connectedPeers, with: .reliable)
      } catch {
        // 5
        let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
      }
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    dismiss(animated: true)
    
    images.insert(image, at: 0)
    collectionView.reloadData()
    // 1
    guard let mcSession = mcSession else { return }
    
    // 2
    if mcSession.connectedPeers.count > 0 {
      // 3
      if let imageData = image.pngData() {
        // 4
        do {
          try mcSession.send(imageData, toPeers: mcSession.connectedPeers, with: .reliable)
        } catch {
          // 5
          let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
          ac.addAction(UIAlertAction(title: "OK", style: .default))
          present(ac, animated: true)
        }
      }
    }
  }
  
  // MARK: - UICollectionViewController
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
    
    if let imageView = cell.viewWithTag(1000) as? UIImageView {
      imageView.image = images[indexPath.item]
    }
    
    return cell
  }
  
  // MARK: - MCSessionDelegate, MCBrowserViewControllerDelegate
  
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
  }
  
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    
  }
  
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    
  }
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true)
  }
  
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
    case .connected:
      print("Connected: \(peerID.displayName)")
      
    case .connecting:
      print("Connecting: \(peerID.displayName)")
      
    case .notConnected:
      print("Not Connected: \(peerID.displayName)")
      DispatchQueue.main.async { [weak self] in
        let ac = UIAlertController(title: "User disconnected", message: "User \(peerID.displayName) disconnected", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self?.present(ac, animated: true)
      }
    @unknown default:
      print("Unknown state received: \(peerID.displayName)")
    }
  }
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    DispatchQueue.main.async { [weak self] in
      if let image = UIImage(data: data) {
        self?.images.insert(image, at: 0)
        self?.collectionView.reloadData()
      } else {
        let string = String(decoding: data, as: UTF8.self)
        let ac = UIAlertController(title: "Greeting message", message: string, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self?.present(ac, animated: true)
      }
    }
  }
  
}

