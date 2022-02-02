//
//  ConcentrationGame.swift
//  Challenge99
//
//  Created by Евгений Карпов on 02.02.2022.
//

import Foundation

class ConcentrationGame {
  init(numberOfPairsCards: Int) {
    for _ in 1...numberOfPairsCards {
      let card = Card()
      cards += [card, card]
    }
  }
  
  var cards = [Card]()
  var indexOfOneAnOnlyFaceUpCard: Int?
  var isFirstCard = false
  var checkingCard: Card?
  func chooseCard(at index: Int) {
//    guard isFirstCard else {
//      isFirstCard = true
//      cards
//      checkingCard = cards[index]
//      return
//    }
//    isFirstCard = false
    
    
    if !cards[index].isMatched {
      //fasle block
      if let matchingIndex = indexOfOneAnOnlyFaceUpCard, matchingIndex != index {
        if cards[matchingIndex].identifier == cards[index].identifier {
          cards[matchingIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
        indexOfOneAnOnlyFaceUpCard = nil
        if isFirstCard {
          DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.allCardsFacedDown()
          }
        }
        isFirstCard.toggle()
      } else {
        //true block
        for flipDown in cards.indices {
          cards[flipDown].isFaceUp = false
        }
        cards[index].isFaceUp = true
        indexOfOneAnOnlyFaceUpCard = index
        isFirstCard.toggle()
      }
    }
  }
  
  func allCardsFacedDown() {
    
    for index in cards.indices {
      
      cards[index].isFaceUp = false
    }
  }
}
