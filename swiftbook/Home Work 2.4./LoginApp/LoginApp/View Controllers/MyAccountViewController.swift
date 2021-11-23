//
//  MyAccountViewController.swift
//  LoginApp
//
//  Created by Евгений Карпов on 21.11.2021.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet var textLabel: UILabel!
    
    //MARK: - Public properties
    
    var userInfo: String = ""
    
    //MARK: - Private properties
    
    private let primaryColor = UIColor(
        red: 109/255,
        green: 210/255,
        blue: 128/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 107/255,
        green: 148/255,
        blue: 230/255,
        alpha: 1
    )
    
    
    //MARK: - View life cyckle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = updateText(withText: userInfo)
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    //MARK: - Private functions
    
    private func updateText(withText text: String) -> String {
        return "\(text)!"
    }
}

// MARK: - Set background color
extension MyAccountViewController {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
