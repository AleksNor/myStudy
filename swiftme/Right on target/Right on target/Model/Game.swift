//
//  Game.swift
//  Right on target
//
//  Created by Евгений Карпов on 07.11.2021.
//

import Foundation

protocol GameProtocol {
    var isGameEnded: Bool { get }
    var currentSecreteValue: Int { get }
    var score: Int { get }
    
    func checkButtonPressed(with value: Int)
    func checkColorResult(label: String, button: String)
    func restartGame()
    func startNewRound()
}


class Game: GameProtocol {
    
    // MARK: - Public properties
    
    public var isGameEnded: Bool {
        if currentRound >= rounds {
            return true
        } else {
            return false
        }
    }
    public var score: Int = 0
    public var currentSecreteValue: Int {
        gameRandomGenerator.currentSecreteValue
    }
    
    // MARK: - Private properties
    
    private var gameRound: GameRoundProtocol = GameRoundClass()
    private var gameRandomGenerator: RandomGeneratorProtocol!
    
    private var rounds: Int = 0
    private var currentRound: Int = 0
    

    init?(startValue: Int, endValue: Int, rounds: Int) {
        guard startValue <= endValue else { return }
        self.rounds = rounds
        gameRandomGenerator = RandomGeneratorClass(minValue: startValue, maxValue: endValue)
    }
    
    // MARK: - Public functions
    
    func checkButtonPressed(with value: Int) {
        score += gameRound.calculateScore(
            with: value,
            secreteValue: currentSecreteValue)
    }
    
    func checkColorResult(label: String, button: String) {
        if label == button {
            score += 1
        }
        currentRound += 1
    }
    
    func restartGame() {
        score = 0
        currentRound = 0
        startNewRound()
    }

    func startNewRound() {
        gameRandomGenerator.setRandomValue()
        currentRound += 1
    }
}
