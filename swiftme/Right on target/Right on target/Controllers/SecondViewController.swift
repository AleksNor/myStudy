//
//  SecondViewController.swift
//  Right on target
//
//  Created by Евгений Карпов on 08.11.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    @IBOutlet var buttonFour: UIButton!
    @IBOutlet var resultlabel: UILabel!
    
    private var game: GameProtocol!
    
    // MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonOne.layer.cornerRadius = 10
        buttonTwo.layer.cornerRadius = 10
        buttonThree.layer.cornerRadius = 10
        buttonFour.layer.cornerRadius = 10
        
        game = Game(startValue: 0, endValue: 255, rounds: 5)
        game.restartGame()
        
        setNewCollorAllButton()
        resultlabel.text = setLabelHex()
    }
    
    // MARK: Взаимодействие Controller-View
    
    @IBAction func hideCurrwntView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkResult(_ sender: UIButton) {
        guard !game.isGameEnded else {
            game.checkColorResult(
                label: resultlabel.text!,
                button: (sender.backgroundColor?.hexString ?? ""))
            gameOverAlert(score: game.score)
            game.restartGame()
            setNewCollorAllButton()
            resultlabel.text = setLabelHex()
            return
        }
        
        game.checkColorResult(
            label: resultlabel.text!,
            button: (sender.backgroundColor?.hexString ?? ""))
        setNewCollorAllButton()
        resultlabel.text = setLabelHex()
        
        
    }

    
    // MARK: Обновление View
    
    func setNewColor(sender: UIButton) {
        sender.backgroundColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1)
    }
    
    func setNewCollorAllButton() {
        setNewColor(sender: buttonOne)
        setNewColor(sender: buttonTwo)
        setNewColor(sender: buttonThree)
        setNewColor(sender: buttonFour)
    }
    
    func setLabelHex() -> String {
        let randomNum = Int.random(in: 1...4)
        switch randomNum {
        case 1:
            return (buttonOne.backgroundColor?.hexString)!
        case 2:
            return (buttonTwo.backgroundColor?.hexString)!
        case 3:
            return (buttonThree.backgroundColor?.hexString)!
        case 4:
            return (buttonFour.backgroundColor?.hexString)!
        default:
            return "Error"
        }
    }
    
    private func gameOverAlert(score: Int) {
        let alert = UIAlertController(
            title: "Game over",
            message: "Ты заработал \(score) очков",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Начать заново",
            style: .default,
            handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
