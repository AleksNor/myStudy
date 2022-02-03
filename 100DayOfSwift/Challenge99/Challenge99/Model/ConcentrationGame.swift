//
//  ConcentrationGame.swift
//  Challenge99
//
//  Created by Евгений Карпов on 02.02.2022.
//

import Foundation

class ConcentrationGame {
  var cards = [Card]()
  var firstCardIndex: Int?
  var isFirstCard = false
  var checkingCard: Card?
  
  init(numberOfPairsCards: Int) {
    for _ in 1...numberOfPairsCards {
      let card = Card()
      cards += [card, card]
    }
  }
  
  func chooseCard(at index: Int, completion: @escaping () -> Void) {
    guard let matchingIndex = firstCardIndex, matchingIndex != index else {
      cards[index].isFaceUp = true
      firstCardIndex = index
      isFirstCard.toggle()
      return
    }
    if cards[matchingIndex].identifier == cards[index].identifier {
      cards[matchingIndex].isMatched = true
      cards[index].isMatched = true
    }
    cards[index].isFaceUp = true
    firstCardIndex = nil
    if isFirstCard {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.allCardsFacedDown()
        completion()
      }
    }
    isFirstCard.toggle()
  }
  
  func allCardsFacedDown() {
    for index in cards.indices {
      cards[index].isFaceUp = false
    }
  }
  
  func restartGame() {
    let cardCount = cards.count
    cards = []
    isFirstCard = false
    firstCardIndex = nil
    for _ in 1...cardCount {
      let card = Card()
      cards += [card, card]
    }
  }
}
