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
    var correctAnswer = 0
    
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
    
    func askQuestion(action: UIAlertAction! = nil) {
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        var title: String
        
        if correctAnswer == sender.tag {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        self.present(ac, animated: true, completion: nil)
    }
    
}

