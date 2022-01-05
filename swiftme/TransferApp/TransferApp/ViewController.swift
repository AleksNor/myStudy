//
//  ViewController.swift
//  TransferApp
//
//  Created by Евгений Карпов on 12.11.2021.
//

import UIKit

class ViewController: UIViewController, DataUpdateProtocol {
    var updatedData: String = "Test String"
    
    @IBOutlet var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    
    @IBAction func editWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        
        //устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    @IBAction func editDatawithProperty(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        editScreen.updatingData = dataLabel.text ?? ""
        
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // Обновляем данные в текстовой метке
    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else {
            return
        }
        destinationController.updatingData = dataLabel.text ?? ""
    }
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    // Передача данных с помощью segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // определяем идентификатор segue
        switch segue.identifier {
        case "toEditScreen":
            // обрабатываем переход
            prepareEditScreen(segue)
        default:
            break
        }
    }
}

