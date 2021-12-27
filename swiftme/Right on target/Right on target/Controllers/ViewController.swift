//
//  ViewController.swift
//  Right on target
//
//  Created by Евгений Карпов on 04.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: GameProtocol!
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    // MARK: - Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(startValue: 1, endValue: 50, rounds: 5)
        game.restartGame()
        updateSecretValueLabel(secretValue: game.currentSecreteValue)
    }

    // MARK: - Взаимодейстие Controller - View
    
    @IBAction func checkButton(_ sender: UIButton) {
        
        let sliderNum = Int(slider.value.rounded())
        
        guard !game.isGameEnded else {
            updateResultLabel(chekResult: sliderNum)
            gameOverAlert(score: game.score)
            game.restartGame()
            updateSecretValueLabel(secretValue: game.currentSecreteValue)
            return
        }
        
        game.checkButtonPressed(with: sliderNum)
        game.startNewRound()
        updateSecretValueLabel(secretValue: game.currentSecreteValue)
        updateResultLabel(chekResult: sliderNum)
    }
    
    @IBAction func hideCurrwntView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Обновление View
    
    private func updateResultLabel(chekResult: Int) {
        resultLabel.text = "Ты выбрал \(chekResult)"
    }
    
    private func updateSecretValueLabel(secretValue: Int) {
        label.text = "Загадано число \(secretValue)"
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
