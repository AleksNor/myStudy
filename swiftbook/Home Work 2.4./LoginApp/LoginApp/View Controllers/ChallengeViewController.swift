//
//  ChallengViewController.swift
//  LoginApp
//
//  Created by Евгений Карпов on 21.11.2021.
//

import UIKit

class ChallengeViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet var welcomLabel: UILabel!
    
    //MARK: - Properties
    var welcomeString: String = ""
    
    //MARK: - View Life Cyckle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText(withText: welcomeString)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText(withText: welcomeString)
    }
    
    //MARK: - Private functions
    private func updateText(withText text: String) {
        welcomLabel.text = "Welcome, \(text)!"
    }
}
