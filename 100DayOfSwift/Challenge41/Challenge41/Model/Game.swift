//
//  Game.swift
//  Challenge41
//
//  Created by Евгений Карпов on 07.12.2021.
//

import Foundation

struct Game {
    private let allWords: [String] = {
        var allWords = [String]()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            guard let startWords = try? String(contentsOf: startWordsURL) else {
                allWords = ["silkworm"]
                return allWords
            }
            allWords = startWords.components(separatedBy: "\n")
        }
        return allWords
    }()
    
    var secretWord: String = ""
    private var correctCharArray = [Character]()

    var wordForShow =  String()
    var currentRound: Int = 0
    
    var levelImage: String {
        switch currentRound {
        case 0:
            return "Hangman-0"
        case 1:
            return "Hangman-1"
        case 2:
            return "Hangman-2"
        case 3:
            return "Hangman-3"
        case 4:
            return "Hangman-4"
        case 5:
            return "Hangman-5"
        case 6:
            return "Hangman-6"
        default:
            return "nosign"
        }
    }
    
    
    mutating func startNewRound() {
        secretWord = allWords.randomElement() ?? "etti"
        correctCharArray = []
        currentRound = 0
    }
    
    mutating func updateSecreteWord() -> String {
        wordForShow = ""
        secretWord.forEach { char in
            guard correctCharArray.contains(char) else {
                wordForShow.append("?")
                return
            }
            wordForShow.append(char.uppercased())
        }
        return wordForShow
    }
    
    mutating func buttonTapped(with buttonTitle: String) {
        if secretWord.contains(Character(buttonTitle.lowercased())) {
            correctCharArray.append(Character(buttonTitle.lowercased()))
        } else {
            currentRound += 1
        }
    }
    
    func isEndedWithRound() -> Bool {
        return currentRound == 6
    }
    
    func isEndedWithWord() -> Bool {
        return wordForShow.lowercased() == secretWord.lowercased()
    }
}
