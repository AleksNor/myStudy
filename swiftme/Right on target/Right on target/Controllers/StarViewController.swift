//
//  StarViewController.swift
//  Right on target
//
//  Created by Евгений Карпов on 08.11.2021.
//

import UIKit

class StarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var secondViewConroller: SecondViewController = getSecondViewController()
    private lazy var viewController: ViewController =
        getViewController()
    
    private func getSecondViewController() -> SecondViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
    return viewController as! SecondViewController }
    
    private func getViewController() -> ViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(identifier: "ViewController")
    return viewController as! ViewController}
    
    @IBAction func startColorGame() {
        self.present(secondViewConroller, animated: true, completion: nil)
    }
    
    @IBAction func starNumGame() {
        self.present(viewController, animated: true, completion: nil)
    }


}
