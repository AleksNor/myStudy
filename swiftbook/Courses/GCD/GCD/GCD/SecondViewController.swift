//
//  SecondViewController.swift
//  GCD
//
//  Created by Евгений Карпов on 16.12.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.logiAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, clouser: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            clouser()
        }
    }
    
    fileprivate func logiAlert() {
        let ac = UIAlertController(title: "Зарегестрированны?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        ac.addTextField { usernameTextField in
            usernameTextField.placeholder = "Введите логи"
        }
        ac.addTextField { userPasswordTextField in
            userPasswordTextField.placeholder = "Введите пароль"
            userPasswordTextField.isSecureTextEntry = true
        }
        present(ac, animated: true)
        
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
