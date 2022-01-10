//
//  ViewController.swift
//  Project22
//
//  Created by Евгений Карпов on 09.01.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet var distanceReading: UILabel!
  @IBOutlet var uuidLabel: UILabel!
  @IBOutlet var circle: UIView!
  
  var locationManager: CLLocationManager?
  var beaconIsSet = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()
    view.backgroundColor = .gray
    circle.layer.cornerRadius = circle.bounds.width / 2
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
      if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
        if CLLocationManager.isRangingAvailable() {
          startScanning()
        }
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
      uuidLabel.text = "\(beacon.uuid)"
      update(distance: beacon.proximity)
      if !beaconIsSet {
        showDetectAlert()
        beaconIsSet = true
      }
    } else {
      update(distance: .unknown)
    }
  }
  
  func startScanning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
    locationManager?.startMonitoring(for: beaconRegion)
    locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
  }
  
  func update(distance: CLProximity) {
    UIView.animate(withDuration: 0.8) {
      switch distance {
      case .far:
        self.circle.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        self.view.backgroundColor = UIColor.blue
        self.distanceReading.text = "FAR"
        
      case .near:
        self.circle.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.view.backgroundColor = UIColor.orange
        self.distanceReading.text = "NEAR"
        
      case .immediate:
        self.circle.transform = CGAffineTransform(scaleX: 1, y: 1)
        self.view.backgroundColor = UIColor.red
        self.distanceReading.text = "RIGHT HERE"
        
      default:
        self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.view.backgroundColor = UIColor.gray
        self.distanceReading.text = "UNKNOWN"
      }
    }
  }
  
  private func showDetectAlert() {
    let ac = UIAlertController(title: "Beacon is found", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
}

