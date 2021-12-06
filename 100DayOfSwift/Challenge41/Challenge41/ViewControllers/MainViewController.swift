//
//  MainViewController.swift
//  Challenge41
//
//  Created by Евгений Карпов on 06.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var game = Game()
    
    @IBOutlet var currentWordLabel: UILabel!
    @IBOutlet var buttonsView: UIView!
    @IBOutlet var hangmanImage: UIImageView!
    
    var letterButtons = [UIButton]()
    var activateButtons = [UIButton]()
    
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        buttonsView.layer.borderWidth = 1
        let borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        buttonsView.layer.borderColor = borderColor.cgColor
        
        for row in 0..<6 {
            for column in 0..<5 {
                let letterbutton = UIButton(type: .system)
                letterbutton.titleLabel?.font = UIFont.systemFont(ofSize: 26)
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
        setLetterButtonTitle()
        startGame()
    }
    
    // MARK: - Private methods
    
    private func setLetterButtonTitle() {
        for i in 0 ..< self.letterButtons.count {
            guard i < alphabet.count else {
                self.letterButtons[i].isHidden = true
                continue
            }
            self.letterButtons[i].setTitle(alphabet[i], for: .normal)
        }
    }
    
    private func startGame() {
        game.startNewRound()
        currentWordLabel.text = game.updateSecreteWord()
        setLevelImage()
        for btn in activateButtons {
            btn.isHidden = false
        }
        activateButtons = []
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        game.buttonTapped(with: buttonTitle)
        sender.isHidden = true
        activateButtons.append(sender)
        setLevelImage()
        currentWordLabel.text = game.updateSecreteWord()
        if game.isEndedWithRound() {
            showBadNextRoundAlert()
        }
        if game.isEndedWithWord() {
            showGoodNextRoundAlert()
        }
    }
    
    private func setLevelImage(){
        guard let image = UIImage(named: game.levelImage) else {
            hangmanImage.image = UIImage(systemName: "nosign")
            return
        }
        hangmanImage.image = image
    }
}

// MARK: - UIAlertController

extension MainViewController {
    private func showBadNextRoundAlert() {
        let ac = UIAlertController(title: "CONGRADULATION!", message: "You are DEAD! current word was \(game.secretWord.uppercased())", preferredStyle: .alert)
        //ac.addAction(UIAlertAction(title: "Let's DO THIS AGAIN!!!!", style: .default, handler: nil))
        let nextRoundAction = UIAlertAction(title: "Let's DO THIS AGAIN!!!!", style: .default, handler: { [weak self] nextRoundAction in
            guard let self = self else {return}
            self.startGame()
        })
        ac.addAction(nextRoundAction)
        present(ac, animated: true)
    }
    
    private func showGoodNextRoundAlert() {
        let ac = UIAlertController(title: "CONGRADULATION!", message: "You are GENIUS!", preferredStyle: .alert)
        let nextRoundAction = UIAlertAction(title: "Let's DO THIS AGAIN!!!!", style: .default, handler: { [weak self] nextRoundAction in
            guard let self = self else {return}
            self.startGame()
        })
        ac.addAction(nextRoundAction)
        present(ac, animated: true)
    }
}

