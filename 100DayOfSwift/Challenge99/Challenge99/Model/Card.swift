//
//  Card.swift
//  Challenge99
//
//  Created by Евгений Карпов on 02.02.2022.
//

import Foundation

struct Card {
  static var identifierNumber: String {
    emojiCollection.randomElement() ?? "🎃"
  }
  static let emojiCollection = ["👇🏼", "🖖", "🎃", "😺", "🦷", "💋", "🦷", "💋", "👇🏼", "🖖", "🎃", "😺", "👮🏻‍♂️", "🧑🏻‍🍳", "👮🏻‍♂️", "🧑🏻‍🍳"]
  
  var isFaceUp = false
  var isMatched = false
  var identifier: String
  
  internal init() {
    self.identifier = Card.identifierNumber
  }
}
