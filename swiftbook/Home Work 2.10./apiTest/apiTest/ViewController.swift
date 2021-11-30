//
//  ViewController.swift
//  apiTest
//
//  Created by Евгений Карпов on 29.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var forzaImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    let forzaURL = "https://forza-api.tk"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshImage))
        
        fetchImage()
    }
    
    
    @objc private func refreshImage() {
//        forzaImage.image = nil
//        activityIndicator.startAnimating()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: forzaURL) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
    
            do {
                let stringURL = try decoder.decode(ForzaImage.self, from: data)
                guard let imageURL = URL(string: stringURL.image) else {
                    return
                }
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    self.forzaImage.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }

            } catch let error {
                print(error)
            }
            }
        } .resume()
            
    }


}

