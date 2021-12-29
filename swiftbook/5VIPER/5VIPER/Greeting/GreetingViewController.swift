//
//  GreetingViewController.swift
//  5VIPER
//
//  Created by Евгений Карпов on 29.12.2021.
//

import UIKit

//На этот протокол будет подписан ViewController
protocol GreetingViewInputProtocol: AnyObject {
    func setGreeting(_ greeting: String)
}


//На этот протокол будет подписан Presenter
protocol GreetingViewOutputProtocol {
    init(view: GreetingViewInputProtocol)
    func didTapShowGreetingButton()
}


//ViewController выполняет функции по обновлению View
class GreetingViewController: UIViewController {
    
    @IBOutlet var greetingLabel: UILabel!
    var presenter: GreetingViewOutputProtocol!
    private let configurator: GreetingConfoguratorInputProtocol = GreetingConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
    
    @IBAction func showGreeting() {
        presenter.didTapShowGreetingButton()
    }
}

// MARK: - GreetingViewInputProtocol

extension GreetingViewController: GreetingViewInputProtocol {
    func setGreeting(_ greeting: String) {
        greetingLabel.text = greeting
    }
}
