//
//  ViewController.swift
//  Project5
//
//  Created by Евгений Карпов on 22.11.2021.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Private properties
    
    private var allWords = [String]()
    private var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        loadUsedWordsAndData()
        startGame()
    }
    
    //MARK: - Private func
    
    private func startGame() {
        guard title == "" else {
            tableView.reloadData()
            return
        }
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func restartGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
     }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()

        let errorTitle: String
        let errorMessage: String

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer.lowercased(), at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    saveUsedWords()
                    return
                } else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            guard let title = title?.lowercased() else { return }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }
        
        showErrorAlert(titile: errorTitle, message: errorMessage)
    }
    
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }

        return true
    }
    
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        guard word.count > 2 else {
            return false
        }
        return misspelledRange.location == NSNotFound
    }
    
    func saveUsedWords() {
        guard let currentWord = title else { return }
        let data = [currentWord : usedWords]
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(data) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "data")
        } else {
            print("Failed to save people")
        }
    }
    
    func loadUsedWordsAndData() {
        var result = [String : [String]]()
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "data") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                result = try jsonDecoder.decode([String: [String]].self, from: savedData)
            } catch  {
                print("Failed to load image Count")
            }
        }
        title = result.keys.first ?? ""
        usedWords = result.values.first ?? []
    }
    
    //MARK: - Show Allert
    
    private func showErrorAlert(titile: String, message: String) {
        let ac = UIAlertController(title: titile, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}

//MARK: - TabelView settings

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

