//
//  ViewController.swift
//  SliderRGB
//
//  Created by Евгений Карпов on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewColor()
        changeLabelText()        
    }
    
    func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    func changeLabelText() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    @IBAction func sliderAction() {
        changeViewColor()
        changeLabelText()
    }


}

