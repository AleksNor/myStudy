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
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.cornerRadius = 5
        button2.layer.cornerRadius = 5
        button3.layer.cornerRadius = 5
        
        button1.layer.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.5, alpha: 0.1).cgColor
        button2.layer.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.5, alpha: 0.1).cgColor
        button3.layer.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.5, alpha: 0.1).cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["Количество моих очков \(score)", self], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func askQuestion(action: UIAlertAction! = nil) {
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "\(countries[correctAnswer].uppercased())! Score: \(score)"
    }

    @IBAction func tappedButton(_ sender: UIButton) {
        var title: String = ""
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            
            sender.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
            
        } completion: { _ in
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        round += 1
        
        if correctAnswer == sender.tag {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())!"
            score -= 1
        }

        
        guard round != 10 else {
            let ac = UIAlertController(title: "\(title) But Game over", message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start New Game", style: .default, handler: askQuestion))
            self.present(ac, animated: true, completion: nil)
            score = 0
            round = 0
            return
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        self.present(ac, animated: true, completion: nil)
    }
    
}

