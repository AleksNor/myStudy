//
//  ViewController.swift
//  Challenge99
//
//  Created by Евгений Карпов on 02.02.2022.
//

import UIKit

final class ViewController: UIViewController {
  //Dependencies
  lazy var game = ConcentrationGame(numberOfPairsCards: (buttonCollection.count + 1) / 2)
  
  // Properties
  var emojiCollection = ["👇🏼", "🖖", "🎃", "😺", "🦷", "💋", "🦷", "💋", "👇🏼", "🖖", "🎃", "😺", "👮🏻‍♂️", "🧑🏻‍🍳", "👮🏻‍♂️", "🧑🏻‍🍳"].shuffled()
  var emojiDictionary = [Int: String]()
  var touches = 0 {
    didSet {
      touchesLabel.text = "Touches: \(touches)"
    }
  }
  
  // UI
  @IBOutlet var buttonCollection: [UIButton]!
  @IBOutlet weak var touchesLabel: UILabel!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    emojiCollection.shuffle()
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
  
//  private func emojiIdentifier(for card: Card) -> String {
//    card.identifier
//    if emojiDictionary[card.identifier] == nil {
//      let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
//      emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
//    }
//    return emojiDictionary[card.identifier] ?? "?"
//  }
  
  // MARK: - Actions
  @IBAction func buttonAction(_ sender: UIButton) {
    touches += 1
    if let buttonIndex = buttonCollection.firstIndex(of: sender) {
      game.chooseCard(at: buttonIndex)
      updateViewFromModel()
    }
  }
}


