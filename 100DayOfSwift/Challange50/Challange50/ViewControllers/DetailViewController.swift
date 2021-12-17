//
//  DetailViewController.swift
//  Challange50
//
//  Created by Евгений Карпов on 15.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    var photoName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photoName = photoName {
            let path = getDocumnetsDirectory().appendingPathComponent(photoName)
            photoImageView.image = UIImage(contentsOfFile: path.path)
        }
    }
    
    func getDocumnetsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
