//
//  TableViewController.swift
//  Challange50
//
//  Created by Евгений Карпов on 15.12.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var photos = [Photo]()
    var savedPhotoName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
        loadPhotos()
    }
    
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }


}

// MARK: - UITabelViewController

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
             fatalError("Unable to dequqe PhotoCell")
        }
        
        let photo = photos[indexPath.row]
        let path = getDocumnetsDirectory().appendingPathComponent(photo.image)
        
        cell.photoImageView.image = UIImage(contentsOfFile: path.path)
        cell.photoNameLabel.text = photo.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.removePhoto(forKey: self.photos[indexPath.row].name)
            self.photos.remove(at: indexPath.row)
            self.savedPhotoName.remove(at: indexPath.row)
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        let photo = photos[indexPath.row]
        vc.photoName = photo.image
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ImagePickerControllerDelegate

extension TableViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumnetsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(name: imageName, image: imageName)
        photos.append(photo)
        savedPhotoName.append(imageName)
        tableView.reloadData()
        
        savePhoto(forKey: imageName, data: photo)
        dismiss(animated: true)
    }
    
    func getDocumnetsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

// MARK: - UIAlertController

extension TableViewController {
    private func addAlert() -> String {
        var resultString: String = "Unknown"
        let ac = UIAlertController(title: "Введи название изображения", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Введи название здесь"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            resultString = ac.textFields?[0].text ?? "1"
        }))
        present(ac, animated: true)
        return resultString
    }
}

// MARK: - UserDefaults

extension TableViewController {
    private func savePhoto(forKey: String, data: Photo) {
        let jsonEncoder = JSONEncoder()
        let userDeafults = UserDefaults.standard
        if let savedData = try? jsonEncoder.encode(data) {
            userDeafults.set(savedData, forKey: forKey)
        } else {
            print("Failed to save photo")
        }
        if let savedData = try? jsonEncoder.encode(savedPhotoName) {
            userDeafults.set(savedData, forKey: "savedPhotoName")
        } else {
            print("Failed to save PhotoName")
        }
    }
    
    private func removePhoto(forKey: String) {
        let userDeafults = UserDefaults.standard
        userDeafults.removeObject(forKey: forKey)
    }
    
    private func loadPhotos() {
        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()
        
        if let savedName = defaults.object(forKey: "savedPhotoName") as? Data {
            do {
                self.savedPhotoName = try jsonDecoder.decode([String].self, from: savedName)
            } catch  {
                print("Failed to load people")
            }
        }
        
        for photoName in savedPhotoName {
            if let savedPhoto = defaults.object(forKey: photoName) as? Data {
                do {
                    let photo = try jsonDecoder.decode(Photo.self, from: savedPhoto)
                    photos.append(photo)
                } catch  {
                    print("Failed to load people")
                }
            }
        }
    }
}
