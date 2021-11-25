//
//  DetailViewController.swift
//  PersonList
//
//  Created by Евгений Карпов on 25.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - IB Outlets
    
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    var currentPerson: Person!
    
    //MARK: - Private properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberLabel.text = "Phone:   \(currentPerson.phoneNumber)"
        emailLabel.text = "E-mail:   \(currentPerson.email)"
        title = currentPerson.getWholeName()
    }
    
    
    
    
}
