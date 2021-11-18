//
//  ViewController.swift
//  TrafficLight
//
//  Created by Евгений Карпов on 18.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var redLight: UIView!
    @IBOutlet var yellowLight: UIView!
    @IBOutlet var greenLight: UIView!
    @IBOutlet var changeButton: UIButton!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewToCircle(redLight)
        changeViewToCircle(yellowLight)
        changeViewToCircle(greenLight)
        
        lightTurnOff(redLight)
        lightTurnOff(yellowLight)
        lightTurnOff(greenLight)
        
        changeButton.layer.cornerRadius = 10
    
    }

    @IBAction func doChange(_ sender: UIButton) {
        sender.setTitle("NEXT", for: .normal)

        guard counter == 0 else {
            guard counter == 1 else {
                lightTurnOn(greenLight)
                lightTurnOff(redLight)
                lightTurnOff(yellowLight)
                counter = 0
                return
            }
            lightTurnOn(yellowLight)
            lightTurnOff(redLight)
            lightTurnOff(greenLight)
            counter = 2
            return
        }
        lightTurnOn(redLight)
        lightTurnOff(greenLight)
        lightTurnOff(yellowLight)
        counter = 1
    }
    
    private func changeViewToCircle(_ sender: UIView) {
        sender.layer.cornerRadius = sender.frame.height / 2
    }
    
    private func lightTurnOff(_ sender: UIView) {
        sender.alpha = 0.3
    }
    
    private func lightTurnOn(_ sender: UIView) {
        sender.alpha = 1
    }
    
}

