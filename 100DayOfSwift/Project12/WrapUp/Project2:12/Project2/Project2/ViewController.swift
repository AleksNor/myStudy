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
        round += 1
        var title: String
        
        if correctAnswer == sender.tag {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())!"
            score -= 1
        }
        
        guard round != 10 else {
            guard score < loadScore() else {
                let ac = UIAlertController(title: "\(title) But Game over", message: "Ты побил рекорд рекорд! И у тебя \(score) очков.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Start New Game", style: .default, handler: askQuestion))
                self.present(ac, animated: true, completion: nil)
                saveScore()
                score = 0
                round = 0
                return
            }
            let ac = UIAlertController(title: "\(title) But Game over", message: "У тебя \(score) очков, и ты не побил рекорд", preferredStyle: .alert)
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
    
    func saveScore() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(score) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "score")
        } else {
            print("Failed to save people")
        }
    }
    
    func loadScore() -> Int {
        var result = 0
        let defaults = UserDefaults.standard
        if let savedImageCount = defaults.object(forKey: "score") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                result = try jsonDecoder.decode(Int.self, from: savedImageCount)
            } catch  {
                print("Failed to load image Count")
            }
        }
        return result
    }
    
}

