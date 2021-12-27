//
//  GameRound.swift
//  Right on target
//
//  Created by Евгений Карпов on 07.11.2021.
//

import Foundation

protocol GameRoundProtocol {
    func calculateScore(with value: Int, secreteValue: Int) -> Int
}

class GameRoundClass: GameRoundProtocol {
    func calculateScore(with value: Int, secreteValue: Int) -> Int {
        var score: Int = 0
        if value > secreteValue {
            score += 50 - value + secreteValue
            return score
        } else if value < secreteValue {
            score += 50 - secreteValue + value
            return score
        } else {
            score += 50
            return score
        }
    }
}


