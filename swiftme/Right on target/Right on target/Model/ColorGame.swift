//
//  ColorGame.swift
//  Right on target
//
//  Created by Евгений Карпов on 08.11.2021.
//

import UIKit


protocol ColorGameProtocol {
    var score: Int {get}
    var randomButtonHex: String {get}
    var isGameEnded: Bool {get}
    
    func setRandomColor() -> UIColor
    func startNewRound()
    func restarGame()
    func checkResult(label: String, button: String)
}

class ColorGameClass: ColorGameProtocol {
    
    var score: Int = 0
    var randomButtonHex: String = ""
    
    private var lastRound: Int
    private var currentRound = 1
    
    
    var isGameEnded: Bool {
        if currentRound >= lastRound {
            return true
        } else {
            return false
        }
    }
    
    init(lastRound: Int)  {
        self.lastRound = lastRound
    }
    

    
    func startNewRound() {
        currentRound += 1
    }
    
    func restarGame() {
        currentRound = 1
        score = 0
    }
    
    func checkResult(label: String, button: String) {
        if label == button {
            score += 1
        }
    }
}


