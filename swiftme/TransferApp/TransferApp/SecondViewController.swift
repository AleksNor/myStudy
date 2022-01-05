//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Евгений Карпов on 12.11.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var dataTextField: UITextField!
    var updatingData: String = ""
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    // Передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
            case "toFirstScreen":
            // обрабатываем переход
            prepareFirstScreen(segue)
            default:
                break
        }
    }
    // подготовка к переходу на экран редактирования
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? ViewController
        else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) { self.navigationController?.viewControllers.forEach {
        viewController in
        (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
}
