//
//  ViewController.swift
//  MVVM1
//
//  Created by Евгений Карпов on 10.12.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            self.nameLabel.text = viewModel.name
            self.secondNameLabel.text = viewModel.secondName
            self.ageLabel.text = viewModel.age
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        // Do any additional setup after loading the view.
    }
}

