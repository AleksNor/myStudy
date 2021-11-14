//
//  ViewController.swift
//  Project2
//
//  Created by Евгений Карпов on 14.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.94, alpha: 1).cgColor
        button2.layer.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.94, alpha: 1).cgColor
        button3.layer.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.94, alpha: 1).cgColor
    }
    
    func askQuestion() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

