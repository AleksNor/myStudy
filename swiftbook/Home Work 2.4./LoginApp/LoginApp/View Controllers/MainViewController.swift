//
//  ViewController.swift
//  LoginApp
//
//  Created by Евгений Карпов on 21.11.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IB Outlets
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //MARK: - Private properties
    
    private var user = User(
        login: "User",
        password: "Password",
        person: Person(firstName: "Johnny", lastName: "Thompson"))
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        
        guard let tabBarViewConrolles = tabBarController.viewControllers else {
            return
        }
        
        for viewController in tabBarViewConrolles {
            switch viewController {
            case let challengeViewController as ChallengeViewController:
                challengeViewController.welcomeString = user.login
            case let myAccountViewController as MyAccountViewController:
                myAccountViewController.userInfo = user.person.getWholeName()
            default:
                break
            }
        }
    }
    
    //MARK: - IB Actions
    @IBAction func checkButton(_ sender: UIButton) {
        checkUserNameAndPassword()
        performSegue(withIdentifier: "toBarController", sender: nil)
        
    }
    
    @IBAction func showMyUserName(_ sender: UIButton) {
        alertUser()
    }
    
    @IBAction func showMyPassword(_ sender: UIButton) {
        alertPassword()
    }
    
    
    @IBAction func changeUser() {
        changeUserAlert()
    }
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        userNameTextField.text = nil
        passwordTextField.text = nil
    }

    
    //MARK: - Private functions
    
    private func checkUserNameAndPassword() {
        guard userNameTextField.text == user.login else {
            alertCheckUserNameAndPassword()
            return
        }
        guard passwordTextField.text == user.password else {
            alertCheckUserNameAndPassword()
            return
        }
        return
    }
}
    
    //MARK: - ShowAlerts
extension MainViewController {
    private func showDefaultAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        self.present(ac, animated: true)
    }
    
    private func alertCheckUserNameAndPassword() {
        showDefaultAlert(
            title: "Access denied",
            message: "Wrong User Name or Password")
    }
    
    private func alertUser() {
        showDefaultAlert(
            title: "Your User Name",
            message: "\(user.login)")
    }
    
    private func alertPassword() {
        showDefaultAlert(
            title: "Your Password",
            message: "\(user.password)")
    }
}

//MARK: - ChangeUser Allert
extension MainViewController{
    private func changeUserAlert() {
        let ac = UIAlertController(title: "Change User", message: nil, preferredStyle: .alert)
        ac.addTextField { TextField in
            TextField.placeholder = "Login"
        }
        ac.addTextField { TextField in
            TextField.placeholder = "Password"
        }
        ac.addTextField { TextField in
            TextField.placeholder = "First Name"
        }
        ac.addTextField { TextField in
            TextField.placeholder = "Last Name"
        }
        
        let changeButton = UIAlertAction(title: "Change", style: .default) { _ in
            guard let login = ac.textFields?[0].text,
                  let password = ac.textFields?[1].text,
                  let firstName = ac.textFields?[2].text,
                  let lastName = ac.textFields?[3].text else {
                      return
                  }
            self.user = User(login: login, password: password,
                             person: Person(firstName: firstName, lastName: lastName))
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(changeButton)
        ac.addAction(cancelButton)
        
        present(ac, animated: true, completion: nil)
    }
}



