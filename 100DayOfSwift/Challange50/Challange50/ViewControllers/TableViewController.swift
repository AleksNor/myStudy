//
//  TableViewController.swift
//  Challange50
//
//  Created by Евгений Карпов on 15.12.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photos = StorageManager.shared.fetchData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        let photo = photos[indexPath.row]
        vc.photoName = photo.image
        navigationController?.pushViewController(vc, animated: true)
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
            StorageManager.shared.removePhoto(for: indexPath)
            self.photos.remove(at: indexPath.row)
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Переимновать") { _, _, isDone in
            self.renameAlert(for: indexPath)
            isDone(true)
        }
        return UISwipeActionsConfiguration(actions:  [actionSwipeInstance])
    }
    
}

// MARK: - ImagePickerControllerDelegate

extension TableViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageURL = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumnetsDirectory().appendingPathComponent(imageName)
        if let jpegData = imageURL.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let photo = Photo(name: "Unknown", image: imageName)
        photos.append(photo)
        tableView.reloadData()
        StorageManager.shared.save(photo: photo)
        dismiss(animated: true)
    }
    
    func getDocumnetsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

// MARK: - UIAlertController

extension TableViewController {
    
    private func renameAlert(for indexPath: IndexPath){
        let ac = UIAlertController(title: "Введи название изображения", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Введи название здесь"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = ac.textFields?.first?.text, !text.isEmpty else { return }
            self.photos[indexPath.row].name = text
            StorageManager.shared.renamePhoto(for: indexPath, and: text)
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        })
        present(ac, animated: true)
    }
}

