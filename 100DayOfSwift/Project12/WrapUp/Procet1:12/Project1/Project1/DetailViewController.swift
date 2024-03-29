//
//  DetailViewController.swift
//  Project1
//
//  Created by Евгений Карпов on 12.11.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selctedImage: String?
    var titleImage: String?
    var yNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageToLoad = selctedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        title = titleImage

        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
