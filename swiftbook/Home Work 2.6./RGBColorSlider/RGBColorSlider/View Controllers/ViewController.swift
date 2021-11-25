//
//  ViewController.swift
//  RGBColorSlider
//
//  Created by Евгений Карпов on 17.08.2021.
//

import UIKit

protocol ViewControllerDelegat: AnyObject {
    func changeUIColor(currentColor: UIColor)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    //View Outlet
    @IBOutlet var colorView: UIView!
    
    //Slider Outlet
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greeenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    //TextField Outlet
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    //MARK: - Public properties
    
    weak var delegat: ViewControllerDelegat?
    var currentColor: UIColor = UIColor.black
    
    //MARK: - Private properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 25
        
        addDoneButton(redTextField)
        addDoneButton(greenTextField)
        addDoneButton(blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.backgroundColor = setColor()
        currentColor = setColor()
        setValueForTextField()
        
        navigationItem.hidesBackButton = true
        delegat?.changeUIColor(currentColor: currentColor)
    }
    //MARK: - IB Actions
    
    //Установка значения в текстовое поле, по значению ползунка
    @IBAction func rgbSet(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redTextField.text = toString(sender)
        case 1:
            greenTextField.text = toString(sender)
        case 2:
            blueTextField.text = toString(sender)
        default:
            return
        }
        
        colorView.backgroundColor = setColor()
        currentColor = setColor()
        delegat?.changeUIColor(currentColor: currentColor)
    }
    
    @IBAction func tapDoneButton() {
        dismiss(animated: true)
    }
    
    //MARK: - Private func
    
    private func toString (_ sender: UISlider) -> String {
        return String(format: "%.2f", sender.value)
    }
    
    private func setColor() -> UIColor {
       return UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greeenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    
    private func setValueForTextField() {
        redTextField.text = toString(redSlider)
        greenTextField.text = toString(greeenSlider)
        blueTextField.text = toString(blueSlider)
    }
}


//MARK: - TextField Done button
extension ViewController {
    
    func addDoneButton(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(didTapButton))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }

    @objc private func didTapButton() {
        view.endEditing(true)
    }
}

//MARK: - TextField
extension ViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else {return}
        print(#function)
        
        if let currentValue = Float(text), currentValue <= 1, currentValue >= 0 {
            
            switch textField.tag {
            case 0:
                redSlider.value = currentValue
            case 1:
                greeenSlider.value = currentValue
            case 2:
                blueSlider.value = currentValue
            default:
                break
            }
            colorView.backgroundColor = setColor()
            currentColor = setColor()
            
        } else {
            showAlert(title: "Неправильный формат!", message: "Введи значение от 0 до 1!")
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

