//
//  ViewController.swift
//  Challenge99
//
//  Created by Евгений Карпов on 02.02.2022.
//

import UIKit

final class ViewController: UIViewController {
  lazy var game = ConcentrationGame(numberOfPairsCards: (buttonCollection.count + 1) / 2)
  
  var touches = 0 {
    didSet {
      touchesLabel.text = "Touches: \(touches)"
    }
  }
  
  @IBOutlet var buttonCollection: [UIButton]!
  @IBOutlet weak var touchesLabel: UILabel!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    game.cards.shuffle()
    updateViewFromModel()
  }
  
  // MARK: - Private
  private func updateViewFromModel() {
    for index in buttonCollection.indices {
      let button = buttonCollection[index]
      let card = game.cards[index]
      button.layer.cornerRadius = 15
      if card.isFaceUp {
        button.setTitle(card.identifier, for: .normal)
        button.backgroundColor = .white
      } else {
        button.setTitle("", for: .normal)
        guard card.isMatched else {
          button.backgroundColor = #colorLiteral(red: 1, green: 0.7620360255, blue: 0, alpha: 1)
          continue
        }
        button.isEnabled = false
      }
    }
  }
  
  // MARK: - Actions
  @IBAction func buttonAction(_ sender: UIButton) {
    touches += 1
    if let buttonIndex = buttonCollection.firstIndex(of: sender) {
      game.chooseCard(at: buttonIndex) {
        self.updateViewFromModel()
      }
      updateViewFromModel()
    }
  }
  
  @IBAction func restartGame(_ sender: UIButton) {
    for button in buttonCollection {
      button.isEnabled = true
    }
    game.restartGame()
    updateViewFromModel()
    touches = 0
  }
}


