//
//  ColorViewController.swift
//  RGBColorSlider
//
//  Created by Евгений Карпов on 24.11.2021.
//

import UIKit

class ColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func toViewController() {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.delegat = self
    }
    
    private func changeViewColor(with color: UIColor) {
        self.view.backgroundColor = color
    }

}

extension ColorViewController: ViewControllerDelegat {
    func changeUIColor(currentColor: UIColor) {
        changeViewColor(with: currentColor)
    }
}
