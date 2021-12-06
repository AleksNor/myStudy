//
//  MainViewController.swift
//  Challenge41
//
//  Created by Евгений Карпов on 06.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var currentWordLabel: UILabel!
    @IBOutlet var buttonsView: UIView!
    @IBOutlet var hangmanImage: UIImageView!
    var letterButtons = [UIButton]()
    
    private var allWords = [String]()
    private var usedWords = [String]()
    private var wordForShow = String()
    private var currentSecretWord = String()
    private var correctChar = [Character]()
    private var lives = 6
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    override func loadView() {
        super.loadView()
        
        buttonsView.layer.borderWidth = 1
        let borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        buttonsView.layer.borderColor = borderColor.cgColor
        
        for row in 0..<6 {
            for column in 0..<5 {
                let letterbutton = UIButton(type: .system)
                letterbutton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
                letterbutton.setTitle("W", for: .normal)
                letterbutton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let width = 72
                let height = 53
                
                let frame = CGRect(x: width * column, y: height * row, width: width, height: height)
                letterbutton.frame = frame
                buttonsView.addSubview(letterbutton)
                letterButtons.append(letterbutton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                self.allWords = startWords.components(separatedBy: "\n")
            }
        }
        if self.allWords.isEmpty {
            self.allWords = ["silkworm"]
        }
        
        loadGame()
        
    }
    
    private func loadGame() {
        correctChar = []
        for btn in letterButtons {
            btn.isHidden = false
        }
        currentSecretWord = allWords.randomElement() ?? ""
        checkSecreteWord()
        lives = 6
        for i in 0 ..< self.letterButtons.count {
            guard i < alphabet.count else {
                self.letterButtons[i].isHidden = true
                continue
            }
            self.letterButtons[i].setTitle(alphabet[i], for: .normal)
        }
        setLevelImage()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        if currentSecretWord.contains(Character(buttonTitle.lowercased())) {
            sender.isHidden = true
            correctChar.append(Character(buttonTitle.lowercased()))
        } else {
            lives -= 1
        }
        checkSecreteWord()
        setLevelImage()
        checkCountOfLives()
    }
    
    private func checkSecreteWord() {
        wordForShow = ""
        for char in currentSecretWord {
            if correctChar.contains(char) {
                wordForShow.append(char.uppercased())
            } else {
                wordForShow.append("?")
            }
        }
        currentWordLabel.text = wordForShow
    }
    
    private func setLevelImage(){
        var currentImage = UIImage()
        switch lives {
        case 0:
            currentImage = UIImage(named: "Hangman-6")!
        case 1:
            currentImage = UIImage(named: "Hangman-5")!
        case 2:
            currentImage = UIImage(named: "Hangman-4")!
        case 3:
            currentImage = UIImage(named: "Hangman-3")!
        case 4:
            currentImage = UIImage(named: "Hangman-2")!
        case 5:
            currentImage = UIImage(named: "Hangman-1")!
        case 6:
            currentImage = UIImage(named: "Hangman-0")!
        default:
            currentImage = UIImage(systemName: "nosign")!
        }
        hangmanImage.image = currentImage
    }
    
    private func checkCountOfLives() {
        if lives == 0 {
            let ac = UIAlertController(title: "CONGRADULATION", message: "You are dead!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's DO THIS!!!!", style: .default, handler: nil))
            present(ac, animated: true, completion: loadGame)
        }
    }
    
    
    
    
}

