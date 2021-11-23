//
//  ViewController.swift
//  LoginApp
//
//  Created by Евгений Карпов on 21.11.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var sometext: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//        case "toBarController":
//            prepareBarController(segue)
//        default:
//            break
//        }
//    }
//
//    private func prepareBarController(_ segue: UIStoryboardSegue) {
//        guard let destinationController = segue.destination as? ChallengViewController else {return}
//        print("zashel")
//        destinationController.welcomeString = userNameTextField.text ?? ""
//    }
    
    @IBAction func chechButton(_ sender: UIButton) {
        sometext = userNameTextField.text ?? ""
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storybord.instantiateViewController(withIdentifier: "ChallengViewController") as! ChallengViewController
        editScreen.welcomeString = sometext
        
        // передаем необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            sometext = updatedValue
            updateText(withText: updatedValue)
        }
//        print(editScreen.welcomeString)
//        print(userNameTextField.text ?? "aaa")
        
//        tabBarController?.present(editScreen, animated: true, completion: nil)
//       checkUserNameAndPassword()
//        performSegue(withIdentifier: "toBarController", sender: nil)
        
    }
    
    @IBAction func showMyUserName(_ sender: UIButton) {
        alertUser()
    }
    
    @IBAction func showMyPassword(_ sender: UIButton) {
        alertPassword()
    }
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        userNameTextField.text = nil
        passwordTextField.text = nil
    }
    
    private func checkUserNameAndPassword() {
        guard userNameTextField.text == "User" else {
            alertCheckUserNameAndPassword()
            return
        }
        guard passwordTextField.text == "Password" else {
            alertCheckUserNameAndPassword()
            return
        }
        return
    }
    
    private func alertCheckUserNameAndPassword() {
        let ac = UIAlertController(title: "Access denied", message: "Wrong User Name or Password", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(ac, animated: true)
    }
    
    private func alertUser() {
        let ac = UIAlertController(title: "Your User Name", message: "User", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(ac, animated: true)
    }
    
    private func alertPassword() {
        let ac = UIAlertController(title: "Your Password", message: "Password", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(ac, animated: true)
    }
    

}

