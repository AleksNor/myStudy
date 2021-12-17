//
//  ViewController.swift
//  Project13
//
//  Created by Евгений Карпов on 17.12.2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var intesity: UISlider!
    @IBOutlet var imageView: UIImageView!
    var currentImage: UIImage! {
        didSet {
            guard let image = currentImage else {return}
            imageView.image = image
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "InstaFilter"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(importPicture))
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
    }

    @IBAction func changeFilter(_ sender: Any) {
    }
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func intesityChanged(_ sender: Any) {
        
    }
    
}

