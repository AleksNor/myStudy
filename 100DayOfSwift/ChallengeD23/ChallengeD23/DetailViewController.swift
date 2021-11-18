//
//  DetailViewController.swift
//  ChallengeD23
//
//  Created by Евгений Карпов on 18.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var someImageView: UIImageView!
    
    var selectedImage: String?
    var imageTitle: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = selectedImage {
            someImageView.image = UIImage(named: image)
            
            title = image.capitalized
            someImageView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.3)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = someImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
