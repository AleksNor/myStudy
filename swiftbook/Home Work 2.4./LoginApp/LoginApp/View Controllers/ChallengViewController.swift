//
//  ChallengViewController.swift
//  LoginApp
//
//  Created by Евгений Карпов on 21.11.2021.
//

import UIKit

class ChallengViewController: UIViewController {

    @IBOutlet var welcomLabel: UILabel!
    
    var completionHandler: ((String) -> Void)?
    var welcomeString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText(withText: welcomeString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText(withText: welcomeString)
    }
    
    func updateText(withText text: String) {
        welcomLabel.text = text
    }
}
