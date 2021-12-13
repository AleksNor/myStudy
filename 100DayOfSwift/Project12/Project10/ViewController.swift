//
//  ViewController.swift
//  Project10
//
//  Created by Евгений Карпов on 07.12.2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var people = [Person]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            if let decodePeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                people = decodePeople
            }
        }
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        
        
//        if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//            picker.sourceType = UIImagePickerController.SourceType.camera
//        } else
//        {
//            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
       
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumnetsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
        save()
    }
    
    func getDocumnetsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

// MARK: - CollectionView

extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequqe PersonCell")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumnetsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 4/*cell.imageView.bounds.width/2*/
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Выбери действие", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "Изменить имя", style: .default) { [weak self] _ in
            let alertc = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            
            alertc.addTextField()
            
            alertc.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak alertc] _ in
                
                guard let newName = alertc?.textFields?[0].text else { return }
                person.name = newName
                
                self?.collectionView.reloadData()
                self?.save()
            })
            self?.present(alertc, animated: true)
        })
        
        ac.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] _ in
            self?.remove()
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
        }))
        
        
        present(ac, animated: true)
    }
    
    func save()  {
        if let savedData = try? NSKeyedArchiver.archivedData(
            withRootObject: people,
            requiringSecureCoding: false) {
            let deafaults = UserDefaults.standard
            deafaults.set(savedData, forKey: "people")
        }
    }
    
    func remove() {
            let deafaults = UserDefaults.standard
            deafaults.removeObject(forKey: "people")
    }
}
